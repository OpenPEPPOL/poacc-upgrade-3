<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:u="utils"
        schemaVersion="iso" queryBinding="xslt2">

  <title>Common PEPPOL rules for Post-Award</title>

  <ns uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" prefix="cbc"/>
  <ns uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" prefix="cac"/>
  <ns uri="utils" prefix="u"/>
  

  <function xmlns="http://www.w3.org/1999/XSL/Transform" name="u:gln" as="xs:boolean">
    <param name="val"/>
    <variable name="length" select="string-length($val) - 1"/>
    <variable name="digits" select="reverse(for $i in string-to-codepoints(substring($val, 0, $length + 1)) return $i - 48)"/>
    <variable name="weightedSum" select="sum(for $i in (0 to $length - 1) return $digits[$i + 1] * (1 + ((($i + 1) mod 2) * 2)))"/>
    <value-of select="10 - ($weightedSum mod 10) = number(substring($val, $length + 1, 1))"/>
  </function>


  <pattern>
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

  <pattern>
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
   
  </pattern>

 </schema>
