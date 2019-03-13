namespace Users.Authentication.Tokens
{
    using Microsoft.IdentityModel.Tokens;
    using System;
    using System.Collections.Generic;
    using System.IdentityModel.Tokens.Jwt;
    using System.Security.Claims;
    using System.Text;

    public class Token
    {
        public static string GetJWTToken(
            List<Claim> claims,
            string key,
            int expireDays)
        {
            var tokenHandler = new JwtSecurityTokenHandler();

            return tokenHandler.WriteToken(
                tokenHandler.CreateToken(
                    new SecurityTokenDescriptor
                    {
                        Subject = new ClaimsIdentity(claims),
                        Expires = DateTime.UtcNow.AddDays(expireDays),
                        SigningCredentials = new SigningCredentials(
                            new SymmetricSecurityKey(Encoding.ASCII.GetBytes(key)),
                            SecurityAlgorithms.HmacSha256Signature)
                    }));
        }
    }
}