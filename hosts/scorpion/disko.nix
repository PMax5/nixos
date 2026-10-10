{ ... }:

let
  disk = "/dev/disk/by-id/nvme-INTEL_SSDPEKKF256G7L_BTPY81060549256D";
in
{
  disko.devices.disk.scorpion = {
    type = "disk";
    device = disk;

    content = {
      type = "gpt";

      partitions = {
        ESP = {
          size = "1G";
          type = "EF00";

          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [
              "fmask=0077"
              "dmask=0077"
            ];
          };
        };

        root = {
          size = "100%";

          content = {
            type = "luks";
            name = "cryptroot";

            settings = {
              allowDiscards = false;
            };

            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
        };
      };
    };
  };
}
