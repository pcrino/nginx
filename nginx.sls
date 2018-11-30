nginx-ppa:
  pkgrepo.managed:
    - name: ppa:nginx/stable
    - require_in: nginx

nginx:
  pkg.latest:
    - refresh: True

  service.running:
    - reload: True
    - enable: True
    - watch:
      - pkg: nginx

/etc/nginx/sites-available/webserver.conf:
  file.managed:
    - source: salt://nginx/webserver.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
      server_name: {{ grains.host }}
    - require_in:
      - file: /etc/nginx/sites-enabled/webserver.conf

/etc/nginx/sites-enabled/webserver.conf:
  file.symlink:
    - target: /etc/nginx/sites-available/webserver.conf
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/default:
  file:
    - absent
    - require:
      - pkg: nginx