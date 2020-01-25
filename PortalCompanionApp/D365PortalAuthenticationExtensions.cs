using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using Org.BouncyCastle.Crypto.Parameters;
using Org.BouncyCastle.Security;
using System;
using System.Net.Http;
using System.Security.Cryptography;
using System.Threading.Tasks;

namespace PortalCompanionApp
{
    public static class D365PortalAuthenticationExtensions
    {
        private static HttpClient _httpClient;

        public static AuthenticationBuilder AddD365PortalAuthentication(this IServiceCollection services, string domain, string applicationId)
        {
            var sp = services.BuildServiceProvider();
            _httpClient = sp.GetService<HttpClient>();

            return services.AddAuthentication(x =>
            {
                x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            }).AddJwtBearer(options =>
            {
                options.TokenValidationParameters = new TokenValidationParameters
                {
                    // Clock skew compensates for server time drift.
                    // We recommend 5 minutes or less:
                    ClockSkew = TimeSpan.FromMinutes(5),
                    // Specify the key used to sign the token:
                    RequireSignedTokens = true,
                    IssuerSigningKey = GetSecurityKey(domain).Result,
                    // Ensure the token hasn't expired:
                    RequireExpirationTime = true,
                    ValidateLifetime = true,
                    // Ensure the token audience matches our audience value (default true):
                    ValidateAudience = true,
                    ValidAudience = applicationId,
                    // Ensure the token was issued by a trusted authorization server (default true):
                    ValidateIssuer = true,
                    ValidIssuer = domain
                };
            });

        }

        private static async Task<SecurityKey> GetSecurityKey(string domain)
        {
            var response = await _httpClient.GetAsync($"https://{domain}/_services/auth/publickey");
            var content = await response.Content.ReadAsStringAsync();

            var rs256Token = content.Replace("-----BEGIN PUBLIC KEY-----", "");
            rs256Token = rs256Token.Replace("-----END PUBLIC KEY-----", "");
            rs256Token = rs256Token.Replace("\n", "");

            var keyBytes = Convert.FromBase64String(rs256Token);

            var asymmetricKeyParameter = PublicKeyFactory.CreateKey(keyBytes);
            var rsaKeyParameters = (RsaKeyParameters)asymmetricKeyParameter;

            var rsa = new RSACryptoServiceProvider();
            var rsaParameters = new RSAParameters
            {
                Modulus = rsaKeyParameters.Modulus.ToByteArrayUnsigned(),
                Exponent = rsaKeyParameters.Exponent.ToByteArrayUnsigned()
            };

            rsa.ImportParameters(rsaParameters);
            return new RsaSecurityKey(rsa);

        }
    }
}
