{ ... }: 
{
  virtualisation.oci-containers.containers.stirling-pdf = {
    image = "stirlingtools/stirling-pdf:3.1.0";
    autoStart = true;
    ports = ["127.0.0.1:3005:8080"];
    volumes = ["stirling_pdf_data:/configs"];
    environment = {
      DISABLE_ADDITIONAL_FEATURES = "false";
      SECURITY_ENABLELOGIN = "false";
    };
  };
}
