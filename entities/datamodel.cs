// Generated by https://quicktype.io

namespace QuickType
{
  using System;
  using System.Collections.Generic;

  using System.Globalization;
  using Newtonsoft.Json;
  using Newtonsoft.Json.Converters;

  public partial class AstServiceModel
  {
    [JsonProperty("schema")]
    public string Schema { get; set; }

    [JsonProperty("modelmountpath")]
    public string Modelmountpath { get; set; }

    [JsonProperty("containermodelroot")]
    public string Containermodelroot { get; set; }

    [JsonProperty("containerns")]
    public string Containerns { get; set; }

    [JsonProperty("containerreponame")]
    public string Containerreponame { get; set; }

    [JsonProperty("containerrepotag")]
    public string Containerrepotag { get; set; }

    [JsonProperty("serverport")]
    public long Serverport { get; set; }

    [JsonProperty("docker_mode")]
    public string DockerMode { get; set; }

    [JsonProperty("docker_run_args")]
    public string DockerRunArgs { get; set; }

    [JsonProperty("callprotocol")]
    public string Callprotocol { get; set; }

    [JsonProperty("hostdns")]
    public string Hostdns { get; set; }

    [JsonProperty("astservers")]
    public Astserver[] Astservers { get; set; }
  }

  public partial class Astserver
  {
    [JsonProperty("modelname")]
    public string Modelname { get; set; }

    [JsonProperty("containername")]
    public string Containername { get; set; }

    [JsonProperty("uiname")]
    public string Uiname { get; set; }

    [JsonProperty("port")]
    public long Port { get; set; }
  }

  public partial class AstServiceModel
  {
    public static AstServiceModel FromJson(string json) => JsonConvert.DeserializeObject<AstServiceModel>(json, QuickType.Converter.Settings);
  }

  public static class Serialize
  {
    public static string ToJson(this AstServiceModel self) => JsonConvert.SerializeObject(self, QuickType.Converter.Settings);
  }

  internal static class Converter
  {
    public static readonly JsonSerializerSettings Settings = new JsonSerializerSettings
    {
      MetadataPropertyHandling = MetadataPropertyHandling.Ignore,
      DateParseHandling = DateParseHandling.None,
      Converters = {
        new IsoDateTimeConverter { DateTimeStyles = DateTimeStyles.AssumeUniversal }
      },
    };
  }
}
