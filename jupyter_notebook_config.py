# Configuration file for jupyter-notebook.

c.ServerProxy.servers = {
    'omeroweb': {
        'command': ['/home/jovyan/omero-web-proxy.sh', '{port}', '{base_url}'],
        'timeout': 120,
        'launcher_entry': {
            'enabled': True,
            'icon_path': '/home/jovyan/.jupyter/omero-logomark.svg',
            'title': 'OMERO.web',
        },
    },
}
