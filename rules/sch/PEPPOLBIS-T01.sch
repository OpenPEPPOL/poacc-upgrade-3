<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:u="utils" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    schemaVersion="iso" queryBinding="xslt2">
    
    <title>Rules for PEPPOL BIS 3.0 Order</title>
    
    
    <ns uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" prefix="cbc"/>
    <ns uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" prefix="cac"/>
    <ns uri="urn:oasis:names:specification:ubl:schema:xsd:Order-2" prefix="ubl-order"/>
    <ns uri="http://www.w3.org/2001/XMLSchema" prefix="xs"/>
    <ns uri="utils" prefix="u"/>
    
    <xsl:key name="k_lineId"  match="cac:LineItem" use="cbc:ID"/>
    
    
    <!-- Functions -->
    
    <function xmlns="http://www.w3.org/1999/XSL/Transform" name="u:slack" as="xs:boolean">
        <param name="exp" as="xs:decimal"/>
        <param name="val" as="xs:decimal"/>
        <param name="slack" as="xs:decimal"/>
        <value-of select="xs:decimal($exp + $slack) &gt;= $val and xs:decimal($exp - $slack) &lt;= $val"/>
    </function>

<!--     <include href="parts/common.sch"/> -->
    <include href="../../target/generated/T01-basic.sch"/>
    <include href="parts/PEPPOL-M-T01-test.sch"/>

    <!-- TODO Rules specific to PEPPOL BIS Order 3.0 -->

</schema>
