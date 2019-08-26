using Microsoft.Xrm.Sdk;
using System;
using System.Collections.Generic;
using System.IO;
using System.Runtime.Serialization.Json;
using System.Text;
using CCMS.Common.Services.CommonServices;
using Microsoft.Xrm.Sdk.Messages;
using Microsoft.Xrm.Sdk.Metadata;
using System.Security.Cryptography;

namespace CCMS.Common
{
    public class HashHelper
    {
     public static string Hash(string stringToHash, Guid GUIDKey)
        {
            try
            {
                //Create a Secret Key from the Record GUID
                byte[] secretkey = GUIDKey.ToByteArray();
                var encoding = new System.Text.ASCIIEncoding();
                byte[] messageBytes = encoding.GetBytes(stringToHash);

                // Initialize the keyed hash object.
                using (HMACSHA384 hmac = new HMACSHA384(secretkey))
                {
                    // Compute the hash of the input file.
                    byte[] hashValue = hmac.ComputeHash(messageBytes);
                    return Convert.ToBase64String(hashValue);
                }
            }
            catch (IOException e)
            {
                return string.Empty;
            }
        }
    }
}
