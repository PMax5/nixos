{
  stirlingPdf = {
    clientId = "stirling-pdf";
    provider = "oidc";
    issuer = "https://auth.pedromax.pt";
    redirectUri = "https://pdf.pedromax.pt/login/oauth2/code/oidc";
    scopes = [
      "openid"
      "profile"
      "email"
    ];
  };
}
