<?xml version="1.0" encoding="UTF-8"?>
<pattern xmlns="http://purl.oclc.org/dsdl/schematron">

    <rule context="/*">
        <assert id="PEPPOL-COMMON-R003"
                test="not(@*:schemaLocation)"
                flag="warning">Document SHOULD not contain schema location.</assert>

    </rule>

    <rule context="cbc:IssueDate | cbc:DueDate | cbc:TaxPointDate | cbc:StartDate | cbc:EndDate | cbc:ActualDeliveryDate">
        <assert id="PEPPOL-COMMON-R030"
                test="(string(.) castable as xs:date) and (string-length(.) = 10)"
                flag="fatal">A date must be formatted YYYY-MM-DD.</assert>
    </rule>

    <rule context="cbc:ID[@schemeID = '0088']">
        <assert id="PEPPOL-COMMON-R040"
                test="matches(., '^[0-9]+$') and u:gln(.)"
                flag="warning">Invalid GLN number provided.</assert>
    </rule>
    <rule context="cbc:EndpointID[@schemeID = '0192'] | cac:PartyIdentification/cbc:ID[@schemeID = '0192'] | cbc:CompanyID[@schemeID = '0192']">
        <assert id="PEPPOL-COMMON-R041"
                test="matches(., '^[0-9]{9}$') and u:mod11(.)"
                flag="fatal">Invalid Norwegian organization number provided.</assert>
    </rule>

</pattern>
