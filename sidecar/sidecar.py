import docker

client = docker.APIClient(base_url='unix://var/run/docker.sock')

# data_dir = "osparc-data"
# volume_name = "s3fs-mnt"
# volume_attributes = [v for v in client.volumes()["Volumes"] if v["Name"] == volume_name]
# mount_point = volume_attributes[0]["Mountpoint"]

# print(mount_point)
mount_point = "/tmp/bla"
container = client.create_container(
    image='osparc-car',
    volumes=['/data'],
    detach=False,
    host_config=client.create_host_config(binds=[f"{mount_point}:/data:rw"],
        auto_remove = True,
        devices = ["/dev/fuse:/dev/fuse"],
        privileged = True,
    )
)
client.start(container)
for log in client.logs(container.get("Id"), stream=True):
    print(log)