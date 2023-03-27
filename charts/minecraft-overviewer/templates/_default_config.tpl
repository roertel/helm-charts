{{- define "config.py" -}}
worlds["World"] = "/srv/world"
outputdir = "/tmp/overviewer"
texturepath = "/srv/minecraft_server.{{ .Values.minecraftVersion }}.jar"
renders["day"] = {
        "world": "World",
        "title": "Daytime",
        "rendermode": "smooth_lighting",
        "dimension": "overworld"
}
renders["night"] = {
        "world": "World",
        "title": "Nighttime",
        "rendermode": "smooth_night",
        "dimension": "overworld"
}
renders["nether"] = {
        "world": "World",
        "title": "Nether",
        "rendermode": "nether_smooth_lighting",
        "dimension": "nether"
}
{{- end }}
