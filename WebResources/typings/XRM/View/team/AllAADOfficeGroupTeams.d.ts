declare namespace Views.team {
  interface AllAADOfficeGroupTeams {
    teamtype: string;
    teamtype_Value: SDK.OptionSet<team_type>;
    teamid: string;
    teamid_Value: string;
    name: string;
    name_Value: string;
    businessunitid: string;
    businessunitid_Value: SDK.EntityReference;
  }
}
