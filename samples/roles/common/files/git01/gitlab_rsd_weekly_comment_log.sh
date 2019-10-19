#!/bin/sh
## GitLabのコメント収集スクリプト(git01.mdomainに配置)
# 30 0 * * 5 /bin/sh /root/gitlab_rsd_weekly_comment_log.sh
#
# ◆コメント抽出条件
# 　・毎週金曜日 00:30 に実行する
# 　・作成日時（created_at）が前週の金曜日から今週の木曜日までのコメントを抽出する
# 　・サービス名、作成日時（created_at）順に並べる
# 　・コメントから改行コードを除去する
# 　・各列はタブ区切りで抽出する（Excelに貼り付けて分析する想定）
#
#
# ◆抽出した情報の見方
# 　・nameはプロジェクト名
# 　・現状はプランチ横断の結果になる
# 　・author_id でMRかcommitのどちらに追加したコメントか判断
# 　・author_id がMergeRequest、discussion_id あり、commit_id なし の場合、MRのディスカッションタブで追加したコメントを表す
# 　・author_id がMergeRequest、discussion_id あり、commit_id あり の場合、MRのChangesなどから行に追加したコメントを表す。同じ行へのコメント追加時は、同じdiscussion_idになる
# 　・author_id がCommit、line_code なし の場合、commits画面下部のコミット自体に対するコメントを表す。
# 　・author_id がCommit、line_code あり の場合、commits画面で行に追加したコメントを表す。同じ行へのコメント追加時は、同じdiscussion_idになる
#
# ◆備考
# 現状は sazabi と sazabi-edi にのみ対応
#
#
#
# 　 project_id | name |         created_at         |         updated_at         |  author_id   |              discussion_id               |                commit_id                 |                  line_code                   |                 note                 | noteable_id | updated_by_id | resolved_at | resolved_by_id |  id   |   type
# 　------------+------+----------------------------+----------------------------+--------------+------------------------------------------+------------------------------------------+----------------------------------------------+--------------------------------------+-------------+---------------+-------------+----------------+-------+----------
# 　        331 | test | 2018-06-21 06:15:17.444112 | 2018-06-21 06:36:45.112943 | MergeRequest | 5b494e4917e1d81b917e49eb0abaa9c1f5a1b784 |                                          |                                              | デスカッション１                     |        7529 |            16 |             |                | 96411 |
# 　        331 | test | 2018-06-21 06:15:23.876951 | 2018-06-21 06:15:23.876951 | MergeRequest | 3862046d9a8b033d54c519fa9bba7e05cbd7f439 |                                          |                                              | デスカッション２                     |        7529 |               |             |                | 96412 |
# 　        331 | test | 2018-06-21 06:15:46.268712 | 2018-06-21 06:19:17.623668 | MergeRequest | 2508dafff48b661c7702c429fbe31407914547c7 | 6d2a8dd58c95126595cf1840142d90c08b1a82fb | e0c9035898dd52fc65c41454cec9c4d2611bfb37_3_3 | MR1に対する行へのコメント１ （修正） |        7529 |            16 |             |                | 96413 | DiffNote
# 　        331 | test | 2018-06-21 06:23:22.704912 | 2018-06-21 06:23:22.704912 | MergeRequest | 2508dafff48b661c7702c429fbe31407914547c7 | 6d2a8dd58c95126595cf1840142d90c08b1a82fb | e0c9035898dd52fc65c41454cec9c4d2611bfb37_3_3 | MR1に対する行へのコメント１への返信  |        7529 |               |             |                | 96422 | DiffNote
# 　        331 | test | 2018-06-21 06:26:13.03972  | 2018-06-21 06:27:08.026616 | Commit       | 97a61d3b7f8b7508b747efbeb0fdfadfda8dd245 | 6d2a8dd58c95126595cf1840142d90c08b1a82fb | e0c9035898dd52fc65c41454cec9c4d2611bfb37_2_2 | commitへの行コメント１（編集）       |             |            16 |             |                | 96426 | DiffNote
# 　        331 | test | 2018-06-21 06:26:21.960198 | 2018-06-21 06:27:25.954171 | Commit       | 97a61d3b7f8b7508b747efbeb0fdfadfda8dd245 | 6d2a8dd58c95126595cf1840142d90c08b1a82fb | e0c9035898dd52fc65c41454cec9c4d2611bfb37_2_2 | commitへの行コメント１への返信       |             |            16 |             |                | 96427 | DiffNote
# 　        331 | test | 2018-06-21 06:27:42.188362 | 2018-06-21 06:28:00.283977 | Commit       | cc0fc18ac7fb68c3d471dfa39bc0b959ea3178e8 | 6d2a8dd58c95126595cf1840142d90c08b1a82fb |                                              | commitへの全体コメント１（編集）     |             |            16 |             |                | 96428 |
# 　        331 | test | 2018-06-21 06:28:17.232369 | 2018-06-21 06:28:17.232369 | Commit       | cbe76b8359cfbf1e7f9ba81d10499e4dc935ca54 | 6d2a8dd58c95126595cf1840142d90c08b1a82fb |                                              | commitへの全体コメント２             |             |               |             |                | 96429 |
# 　        331 | test | 2018-06-21 06:49:49.197455 | 2018-06-21 06:49:49.197455 | Commit       | 79c3c1b455e71eaa272e5d8a606f20b22364157e | bb7f478a3993c4dc86e44f58ce278e86e420c0d5 | 9a900f538965a426994e1e90600920aff0b4e8d2_2_2 | bbファイルへの行コメント１           |             |               |             |                | 96463 | DiffNote
# 　        331 | test | 2018-06-21 06:49:58.049961 | 2018-06-21 06:49:58.049961 | Commit       | 79c3c1b455e71eaa272e5d8a606f20b22364157e | bb7f478a3993c4dc86e44f58ce278e86e420c0d5 | 9a900f538965a426994e1e90600920aff0b4e8d2_2_2 | bbファイルへの行コメント１への返信   |             |               |             |                | 96464 | DiffNote
# 　        331 | test | 2018-06-21 06:50:06.194903 | 2018-06-21 06:50:06.194903 | Commit       | 1db31c42fad25b42e14fbcb628bf4ec22011a9c5 | bb7f478a3993c4dc86e44f58ce278e86e420c0d5 |                                              | bbファイルへの全体コメント１         |             |               |             |                | 96465 |
# 　        331 | test | 2018-06-21 07:08:58.42428  | 2018-06-21 07:08:58.42428  | MergeRequest | 113044063545cf2006fe01a1cd9d481bc5af68a6 | 6d2a8dd58c95126595cf1840142d90c08b1a82fb | e0c9035898dd52fc65c41454cec9c4d2611bfb37_1_1 | aa の別行への行コメント              |        7529 |               |             |                | 96482 | DiffNote
# 　

MAIL_TO="rakuraku-dev@rakus.co.jp"

PROJECT_IDS="60, 62"

PREVIOUS_DAY=`date -d "1 day ago" +'%Y-%m-%d'`
THIS_DAY_LAST_WEEK=`date -d "1 week ago" +'%Y-%m-%d'`


sudo -u gitlab-psql /opt/gitlab/embedded/bin/psql -h /var/opt/gitlab/postgresql -d gitlabhq_production -A -F $'\t' -c "
select
 n.project_id,
 p.name,
 n.created_at,
 n.updated_at,
 n.noteable_type,
 n.author_id,
 n.discussion_id,
 n.commit_id,
 n.line_code,
 regexp_replace(n.note, '\r|\n|\r\n|\t', ' ', 'g') as note,
 n.noteable_id,
 m.iid,
 n.id,
 n.type
from
 notes n
inner join projects p on (n.project_id = p.id)
left outer join merge_requests m on (n.noteable_type = 'MergeRequest' and n.noteable_id = m.id)
where
 p.id in (${PROJECT_IDS}) and
 n.system = 'f' and
 n.created_at between '${THIS_DAY_LAST_WEEK} 00:00:00' and '${PREVIOUS_DAY} 23:59:59'
order by n.project_id, created_at
" | /bin/mail -s "GitLab Weekly Comment Log from ${THIS_DAY_LAST_WEEK} to ${PREVIOUS_DAY}" ${MAIL_TO}
