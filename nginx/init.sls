nginx-ppa:
  pkgrepo.managed:
    - name: ppa:nginx/stable
    - require_in: nginx

nginx:
  pkg.latest:
    - refresh: True

  service:
    - running
    - reload: True
    - enable: True
    - watch:
      - pkg: nginx
