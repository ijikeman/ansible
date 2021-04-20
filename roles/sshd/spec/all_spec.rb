require 'spec_helper'

# Check Package
describe package('postfix') do
  it { should be_installed }
end

Check Running
describe service('postfix') do
 it { should be_enabled }
 it { should be_running }
end

describe port('25') do
 it { should be_listening }
end

if property['POSTFIX_SETTINGS']
  if property['POSTFIX_SETTINGS']['PARENT_INSTANCE_SETTINGS']
    instance_settings = property['POSTFIX_SETTINGS']['PARENT_INSTANCE_SETTINGS']
    if instance_settings['CONFIG_DIRECTORY']
      CONFIG_DIRECTORY = instance_settings['CONFIG_DIRECTORY']
    else
      CONFIG_DIRECTORY = '/etc/postfix/'
    end
  else
    CONFIG_DIRECTORY = '/etc/postfix/'
  end

  describe file(CONFIG_DIRECTORY + '/main.cf') do
    it { should be_file }
    if instance_settings['MAIN_SETTINGS']
      main_settings = instance_settings['MAIN_SETTINGS']
      if main_settings['COMPATIBILITY_LEVEL']
        its(:content) { should match /^\s*compatibility_level\s*=\s*#{Regexp.escape(main_settings['COMPATIBILITY_LEVEL'].to_s)}$/ }
      end
      if main_settings['SOFT_BOUNCE']
        its(:content) { should match /^\s*soft_bounce\s*=\s*#{Regexp.escape(main_settings['SOFT_BOUNCE'].to_s)}$/ }
      end
      if main_settings['QUEUE_DIRECTORY']
        its(:content) { should match /^\s*queue_directory\s*=\s*#{Regexp.escape(main_settings['QUEUE_DIRECTORY'].to_s)}$/ }
      end
      if main_settings['QUEUE_DIRECTORY']
        its(:content) { should match /^\s*queue_directory\s*=\s*#{Regexp.escape(main_settings['QUEUE_DIRECTORY'].to_s)}$/ }
      end
      if main_settings['COMMAND_DIRECTORY']
        its(:content) { should match /^\s*command_directory\s*=\s*#{Regexp.escape(main_settings['COMMAND_DIRECTORY'].to_s)}$/ }
      elsif property['POSTFIX_PATH_ROOT']
        its(:content) { should match /^\s*command_directory\s*=\s*#{property['POSTFIX_PATH_ROOT']}sbin$/ }
      end
      if main_settings['DAEMON_DIRECTORY']
        its(:content) { should match /^\s*daemon_directory\s*=\s*#{Regexp.escape(main_settings['DAEMON_DIRECTORY'].to_s)}$/ }
      elsif property['POSTFIX_PATH_ROOT']
        its(:content) { should match /^\s*daemon_directory\s*=\s*#{property['POSTFIX_PATH_ROOT']}libexec\/postfix$/ }
      end
      if main_settings['DATA_DIRECTORY']
        its(:content) { should match /^\s*data_directory\s*=\s*#{Regexp.escape(main_settings['DATA_DIRECTORY'].to_s)}$/ }
      end
      if main_settings['MAIL_OWNER']
        its(:content) { should match /^\s*mail_owner\s*=\s*#{Regexp.escape(main_settings['MAIL_OWNER'].to_s)}$/ }
      end
      if main_settings['MYHOSTNAME']
        its(:content) { should match /^\s*myhostname\s*=\s*#{Regexp.escape(main_settings['MYHOSTNAME'].to_s)}$/ }
      end
      if main_settings['MYDOMAIN']
        its(:content) { should match /^\s*mydomain\s*=\s*#{Regexp.escape(main_settings['MYDOMAIN'].to_s)}$/ }
      end
      if main_settings['MYORIGIN']
        its(:content) { should match /^\s*myorigin\s*=\s*#{Regexp.escape(main_settings['MYORIGIN'].to_s)}$/ }
      end
      if main_settings['INET_INTERFACES']
        its(:content) { should match /^\s*inet_interfaces\s*=\s*#{Regexp.escape(main_settings['INET_INTERFACES'].to_s)}$/ }
      end
      if main_settings['INET_PROTOCOLS']
        its(:content) { should match /^\s*inet_protocols\s*=\s*#{Regexp.escape(main_settings['INET_PROTOCOLS'].to_s)}$/ }
      end
      if main_settings['PROXY_INTERFACES']
        its(:content) { should match /^\s*proxy_interfaces\s*=\s*#{Regexp.escape(main_settings['PROXY_INTERFACES'].to_s)}$/ }
      end
      if main_settings['MYDESTINATION']
        its(:content) { should match /^\s*mydestination\s*=\s*#{Regexp.escape(main_settings['MYDESTINATION'].to_s)}$/ }
      end
      if main_settings['LOCAL_RECIPIENT_MAPS']
        its(:content) { should match /^\s*local_recipent_maps\s*=\s*#{Regexp.escape(main_settings['LOCAL_RECIPIENT_MAPS'].to_s)}$/ }
      end
      if main_settings['UNKNOWN_LOCAL_RECIPIENT_REJECT_CODE']
        its(:content) { should match /^\s*unknown_local_recipient_reject_code\s*=\s*#{Regexp.escape(main_settings['UNKNOWN_LOCAL_RECIPIENT_REJECT_CODE'].to_s)}$/ }
      end
      if main_settings['MYNETWORKS_STYLE']
        its(:content) { should match /^\s*mynetwork_style\s*=\s*#{Regexp.escape(main_settings['MYNETWORKS_STYLE'].to_s)}$/ }
      end
      if main_settings['MYNETWORKS']
        its(:content) { should match /^\s*mynetworks\s*=\s*#{Regexp.escape(main_settings['MYNETWORKS'].to_s)}$/ }
      end
      if main_settings['RELAY_DOMAINS']
        its(:content) { should match /^\s*relay_domains\s*=\s*#{Regexp.escape(main_settings['RELAY_DOMAINS'].to_s)}$/ }
      end
      if main_settings['RELAYHOST']
        its(:content) { should match /^\s*relayhost\s*=\s*#{Regexp.escape(main_settings['RELAYHOST'].to_s)}$/ }
      end
      if main_settings['RELAY_RECIPIENT_MAPS']
        its(:content) { should match /^\s*relay_recipient_maps\s*=\s*#{Regexp.escape(main_settings['RELAY_RECIPIENT_MAPS'].to_s)}$/ }
      end
      if main_settings['IN_FLOW_DELAY']
        its(:content) { should match /^\s*relay_recipient_maps\s*=\s*#{Regexp.escape(main_settings['IN_FLOW_DELAY'].to_s)}$/ }
      end
      if main_settings['ALIAS_MAPS']
        its(:content) { should match /^\s*alias_maps\s*=\s*#{Regexp.escape(main_settings['ALIAS_MAPS'].to_s)}$/ }
      end
      if main_settings['ALIAS_DATABASE']
        its(:content) { should match /^\s*alias_database\s*=\s*#{Regexp.escape(main_settings['ALIAS_DATABASE'].to_s)}$/ }
      end
      if main_settings['RECIPIENT_DELIMITER']
        its(:content) { should match /^\s*recipient_delimiter\s*=\s*#{Regexp.escape(main_settings['RECIPIENT_DELIMITER'].to_s)}$/ }
      end
      if main_settings['HOME_MAILBOX']
        its(:content) { should match /^\s*home_mailbox\s*=\s*#{Regexp.escape(main_settings['HOME_MAILBOX'].to_s)}$/ }
      end
      if main_settings['MAIL_SPOOL_DIRECTORY']
        its(:content) { should match /^\s*mail_spool_directory\s*=\s*#{Regexp.escape(main_settings['MAIL_SPOOL_DIRECTORY'].to_s)}$/ }
      end
      if main_settings['MAILBOX_COMMAND']
        its(:content) { should match /^\s*mailbox_command\s*=\s*#{Regexp.escape(main_settings['MAILBOX_COMMAND'].to_s)}$/ }
      end
      if main_settings['MAILBOX_TRANSPORT']
        its(:content) { should match /^\s*mailbox_transport\s*=\s*#{Regexp.escape(main_settings['MAILBOX_TRANSPORT'].to_s)}$/ }
      end
      if main_settings['FALLBACK_TRANSPORT']
        its(:content) { should match /^\s*fallback_transport\s*=\s*#{Regexp.escape(main_settings['FALLBACK_TRANSPORT'].to_s)}$/ }
      end
      if main_settings['LUSER_RELAY']
        its(:content) { should match /^\s*luser_relay\s*=\s*#{Regexp.escape(main_settings['LUSER_RELAY'].to_s)}$/ }
      end
      if main_settings['HEADER_CHECKS']
        its(:content) { should match /^\s*header_checks\s*=\s*#{Regexp.escape(main_settings['HEADER_CHECKS'].to_s)}$/ }
      end
      if main_settings['FAST_FLUSH_DOMAINS']
        its(:content) { should match /^\s*fast_flush_domains\s*=\s*#{Regexp.escape(main_settings['FAST_FLUSH_DOMAINS'].to_s)}$/ }
      end
      if main_settings['SMTPD_BANNER']
        its(:content) { should match /^\s*smtpd_banner\s*=\s*#{Regexp.escape(main_settings['SMTPD_BANNER'].to_s)}$/ }
      end
      if main_settings['LOCAL_DESTINATION_CONCURRENCY_LIMIT']
        its(:content) { should match /^\s*local_destination_concurrency_limit\s*=\s*#{Regexp.escape(main_settings['LOCAL_DESTINATION_CONCURRENCY_LIMIT'].to_s)}$/ }
      end
      if main_settings['DEFAULT_DESTINATION_CONCURRENCY_LIMIT']
        its(:content) { should match /^\s*default_destination_concurrency_limit\s*=\s*#{Regexp.escape(main_settings['DEFAULT_DESTINATION_CONCURRENCY_LIMIT'].to_s)}$/ }
      end
      if main_settings['DEBUG_PEER_LEVEL']
        its(:content) { should match /^\s*debug_peer_level\s*=\s*#{Regexp.escape(main_settings['DEBUG_PEER_LEVEL'].to_s)}$/ }
      end
       if main_settings['DEBUGGER_COMMAND']
         debugger_commands=''
         main_settings['DEBUGGER_COMMAND'].each do |debugger_command|
           debugger_commands += '\n'
           debugger_commands += Regexp.escape(debugger_command)
         end
         its(:content) { should match /^\s*debugger_command\s*=\s*#{debugger_commands}$/ }
       end
      if main_settings['SENDMAIL_PATH']
        its(:content) { should match /^\s*sendmail_path\s*=\s*#{Regexp.escape(main_settings['SENDMAIL_PATH'].to_s)}$/ }
      elsif property['POSTFIX_PATH_ROOT']
        its(:content) { should match /^\s*sendmail_path\s*={{ POSTFIX_PATH_ROOT }}sbin\/sendmail.postfix$/ }
      end
      if main_settings['NEWALIASES_PATH']
        its(:content) { should match /^\s*newaliases_path\s*=\s*#{Regexp.escape(main_settings['NEWALIASES_PATH'].to_s)}$/ }
      elsif property['POSTFIX_PATH_ROOT']
        its(:content) { should match /^\s*newaliases_path\s*={{ POSTFIX_PATH_ROOT }}\/bin\/newaliases.postfix$/ }
      end
      if main_settings['MAILQ_PATH']
        its(:content) { should match /^\s*mailq_path\s*=\s*#{Regexp.escape(main_settings['MAILQ_PATH'].to_s)}$/ }
      elsif property['POSTFIX_PATH_ROOT']
        its(:content) { should match /^\s*mailq_path\s*={{ POSTFIX_PATH_ROOT }}\/bin\/mailq.postfix$/ }
      end
      if main_settings['SETGID_GROUP']
        its(:content) { should match /^\s*setgid_group\s*=\s*#{Regexp.escape(main_settings['SETGID_GROUP'].to_s)}$/ }
      end
      if main_settings['HTML_DIRECTORY']
        its(:content) { should match /^\s*html_directory\s*=\s*#{Regexp.escape(main_settings['HTML_DIRECTORY'].to_s)}$/ }
      end
      if main_settings['MANPAGE_DIRECTORY']
        its(:content) { should match /^\s*manpage_directory\s*=\s*#{Regexp.escape(main_settings['MANPAGE_DIRECTORY'].to_s)}$/ }
      elsif property['POSTFIX_PATH_ROOT']
        its(:content) { should match /^\s*manpage_directory\s*={{ POSTFIX_PATH_ROOT }}\share\/man$/ }
      end
      if main_settings['SAMPLE_DIRECTORY']
        its(:content) { should match /^\s*sample_directory\s*=\s*#{Regexp.escape(main_settings['SAMPLE_DIRECTORY'].to_s)}$/ }
      elsif property['POSTFIX_PATH_ROOT']
        its(:content) { should match /^\s*sample_directory\s*={{ POSTFIX_PATH_ROOT }}share\/doc\/postfix\/samples$/ }
      end
      if main_settings['README_DIRECTORY']
        its(:content) { should match /^\s*readme_directory\s*=\s*#{Regexp.escape(main_settings['README_DIRECTORY'].to_s)}$/ }
      elsif property['POSTFIX_PATH_ROOT']
        its(:content) { should match /^\s*readme_directory\s*={{ POSTFIX_PATH_ROOT }}share\/doc\/postfix\/samples$/ }
      end
      if main_settings['SMTPD_TLS_CERT_FILE']
        its(:content) { should match /^\s*smtpd_tls_cert_file\s*=\s*#{Regexp.escape(main_settings['SMTPD_TLS_CERT_FILE'].to_s)}$/ }
      end
      if main_settings['SMTPD_TLS_KEY_FILE']
        its(:content) { should match /^\s*smtpd_tls_key_file\s*=\s*#{Regexp.escape(main_settings['SMTPD_TLS_KEY_FILE'].to_s)}$/ }
      end
      if main_settings['SMTPD_TLS_SECURITY_LEVEL']
        its(:content) { should match /^\s*smtpd_tls_security_level\s*=\s*#{Regexp.escape(main_settings['SMTPD_TLS_SECURITY_LEVEL'].to_s)}$/ }
      end
      if main_settings['SMTP_TLS_CAPATH']
        its(:content) { should match /^\s*smtp_tls_CApath\s*=\s*#{Regexp.escape(main_settings['SMTP_TLS_CAPATH'].to_s)}$/ }
      end
      if main_settings['SMTP_TLS_CAFILE']
        its(:content) { should match /^\s*smtp_tls_CAfile\s*=\s*#{Regexp.escape(main_settings['SMTP_TLS_CAFILE'].to_s)}$/ }
      end
      if main_settings['SMTP_TLS_SECURITY_LEVEL']
        its(:content) { should match /^\s*smtp_tls_security_level\s*=\s*#{Regexp.escape(main_settings['SMTP_TLS_SECURITY_LEVEL'].to_s)}$/ }
      end
      if main_settings['META_DIRECTORY']
        its(:content) { should match /^\s*meta_directory\s*=\s*#{Regexp.escape(main_settings['META_DIRECTORY'].to_s)}$/ }
      end
      if main_settings['SHLIB_DIRECTORY']
        its(:content) { should match /^\s*shlib_directory\s*=\s*#{Regexp.escape(main_settings['SHLIB_DIRECTORY'].to_s)}$/ }
      elsif property['POSTFIX_PATH_ROOT']
        its(:content) { should match /^\s*shlib_directory\s*={{ POSTFIX_PATH_ROOT }}lib64\/postfix$/ }
      end
      if main_settings['ADD_CONFIGS']
        main_settings['ADD_CONFIGS'].each do |add_config|
          its(:content) { should match /^#{add_config}$/ }
        end
      end
      if property['INSTANCE_KIND'] && property['INSTANCE_KIND'] == 'sub'
        its(:content) { should match /^authorized_submit_users\s*=/ }
        its(:content) { should match /^master_service_disable\s*=/ }
        its(:content) { should match /^multi_instance_name\s*=/ }
      end
      if property['POSTFIX_SETTINGS']['MULTI_INSTANCE_SETTINGS']
        its(:content) { should match /^multi_instance_wrapper\s*=/ }
        its(:content) { should match /^multi_instance_enable\s*=/ }
        its(:content) { should match /^multi_instance_directories\s*=/ }
      end
    end
  end

  if instance_settings['ALIASES_SETTINGS']
    if instance_settings['ALIASES_SETTINGS']['PATH']
      ALIAS_PATH = instance_settings['ALIASES_SETTINGS']['PATH']
    else
      ALIAS_PATH = '/etc/aliases'
    end

    if instance_settings['ALIASES_SETTINGS']['ALIASES']
      describe file(ALIAS_PATH) do
        it { should be_file }
        instance_settings['ALIASES_SETTINGS']['ALIASES'].each do |aliase_setting|
          its(:content) { should match /#{aliase_setting}$/ }
        end
      end
      describe file(ALIAS_PATH + '.db') do
        it { should be_file }
      end
    end
  end

  if instance_settings['TRANSPORT_SETTINGS']
    if defined?(instance_settings['TRANSPORT_SETTINGS']['TRANSPORTS'])
      describe file(CONFIG_DIRECTORY + '/transport') do
        it { should be_file }
        instance_settings['TRANSPORT_SETTINGS']['TRANSPORTS'].each do |transport_setting|
          its(:content) { should match /#{Regexp.escape(transport_setting)}$/ }
        end
      end
      describe file(CONFIG_DIRECTORY + '/transport.db') do
        it { should be_file }
      end
    end
  end
end
