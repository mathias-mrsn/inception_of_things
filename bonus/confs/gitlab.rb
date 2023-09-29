external_url 'https://gitlab.mydomain.com'

postgresql['enable'] = false

gitlab_rails['db_adapter'] = 'postgresql'
gitlab_rails['db_encoding'] = 'utf8'
gitlab_rails['db_username'] = 'USERNAME'
gitlab_rails['db_password'] = 'PASSWORD'
gitlab_rails['db_host'] = '127.0.0.1'
gitlab_rails['db_port'] = 5432

web_server['external_users'] = ['www-data']

nginx['enable'] = false
nginx['ssl_prefer_server_ciphers'] = "off"

