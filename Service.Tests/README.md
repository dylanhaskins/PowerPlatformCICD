# Dynamics 365 Service testing

This project is about performing purely API tests that don't require a web browser. It uses
XrmTooling (a library built by Microsoft for communicating with D365) for all it's interactions.

## Setup 

### Login information

Test users are not yet created. Your Office365 user needs to be given access the Dynmaics 365 you'll run 
your tests against. 

Update `app.config` fields:

* CrmUsername with your office365 login (i.e., your DIA email)
* CrmPassword with your password (Don't put this in source control)

## Structure

* TestSettings.cs - Global parameters used in all tests
* Tests - folder where tests are located

## Branching Strategy

Convention is EnvironemntName/Sprint,

E.g

PI3/SP3 - Sandbox 3, Sprint 3

## Determining Entity names from advanced search

Within the UI, in the 'Advanced Find' section, create a query. 

Then click the 'Download Fetch XML' button. This will create an XML version of the search that you created.

It will use names that correspond to ones that XrmTooling can use.

An example result is below:

```xml
<fetch mapping="logical" output-format="xml-platform" version="1.0" distinct="false">
  <entity name="dia_citizenshipbygrantregister">
    <attribute name="dia_name" />
    <attribute name="dia_placeofbirth" />
    <attribute name="dia_gender" />
    <attribute name="dia_familyname" />
    <attribute name="dia_entrytimestamp" />
    <attribute name="dia_entrynumber" />
    <attribute name="dia_dateofbirth" />
    <attribute name="dia_dateacquired" />
    <attribute name="dia_certificatenumber" />
    <attribute name="dia_acquisitiontype" />
    <attribute name="dia_citizenshipbygrantregisterid" />
    <filter type="and">
      <condition value="{AFDF36B4-41EC-E811-A972-000D3AE12CC3}" attribute="dia_person" uitype="contact" uiname="Mary Scots" operator="eq" />
    </filter>
  </entity>
</fetch>
```

The entity name being searched from can be obtained from the 'name' attribute of the entity tag, in this case 'dia_citizenshipbygrantregister'.

The `value` in the `<condition>` element is the unique id of the object. 
The `uitype` attribute is the `entity` being used in criteria, in this case 'contact'.

To make a query out of this you can do the following

```cs
QueryExpression exp = new QueryExpression("dia_citizenshipbygrantregister"); // Using entity name to search on
// Using attributes from condition element
exp.Criteria.AddCondition("dia_person", ConditionOperator.Equal, new Guid("AFDF36B4-41EC-E811-A972-000D3AE12CC3")); 
// Execute query and store the result
var result = _client.RetrieveMultiple(exp);
// Entities stores the list of entities that matched this criteria
result.Entities;
```

This xml should also be able to be used directly in the `GetEntityDataByFetchSearch` method.

# Testing at the right level

The testing pyramid should be kept in view. Most of the testing should be done at UI layel, more at the service layer in this suite and all scenarios in 
the unit tests.