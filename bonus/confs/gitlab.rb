external_url 'https://gitlab.apk8s.dev'

nginx['listen_port'] = 80
nginx['listen_https'] = false
nginx['proxy_set_headers'] = {
  'X-Forwarded-Proto' => 'https',
  'X-Forwarded-Ssl' => 'on'
}

gitlab_rails['gitlab_shell_ssh_port'] = 32222

registry_external_url 'https://reg.gitlab.apk8s.dev'

gitlab_rails['registry_enabled'] = true

registry_nginx['listen_port'] = 5050
registry_nginx['listen_https'] = false
registry_nginx['proxy_set_headers'] = {
  'X-Forwarded-Proto' => 'https',
  'X-Forwarded-Ssl' => 'on'
}

prometheus['monitor_kubernetes'] = false
