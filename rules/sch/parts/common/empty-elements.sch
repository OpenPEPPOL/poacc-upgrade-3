<?xml version="1.0" encoding="UTF-8"?>
<pattern xmlns="http://purl.oclc.org/dsdl/schematron">
    <rule context="cbc:*">
        <assert id="PEPPOL-COMMON-R001"
                test=". != ''"
                flag="fatal">Document MUST not contain empty elements.</assert>
    </rule>

    <rule context="cac:*">
        <assert id="PEPPOL-COMMON-R002"
                test="count(*) != 0"
                flag="fatal">Document MUST not contain empty elements.</assert>
    </rule>
</pattern>
