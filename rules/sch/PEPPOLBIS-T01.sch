<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:u="utils" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xi="http://www.w3.org/2001/XInclude"
        schemaVersion="iso" queryBinding="xslt2">

    <title>Rules for Peppol Order transaction 3.6</title>
    
    <ns uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" prefix="cbc"/>
    <ns uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" prefix="cac"/>
    <ns uri="urn:oasis:names:specification:ubl:schema:xsd:Order-2" prefix="ubl"/>
    <ns uri="http://www.w3.org/2001/XMLSchema" prefix="xs"/>
    <ns uri="utils" prefix="u"/>
    
    <xsl:key name="k_lineId"  match="cac:LineItem" use="cbc:ID"/>
    
    <!-- Functions -->

    <xi:include href="parts/function/gln.xml"/>
    <xi:include href="parts/function/slack.xml"/>
    <xi:include href="parts/function/mod11.xml"/>
	<xi:include href="parts/function/checkCodiceIPA.xml"/>
	<xi:include href="parts/function/addPIVA.xml"/>
	<xi:include href="parts/function/checkCF.xml"/>
	<xi:include href="parts/function/checkCF16.xml"/>
	<xi:include href="parts/function/checkPIVA.xml"/>
	<xi:include href="parts/function/checkPIVAseIT.xml"/>
	<xi:include href="parts/function/mod97-0208.xml"/>
    <xi:include href="parts/function/abn.xml"/>	
	<xi:include href="parts/function/checkSEOrgnr.xml"/>		
	
    <!-- Rules -->

    <include href="parts/common/empty-elements.sch"/>
    <include href="parts/common/rules.sch"/>
    <include href="../../target/generated/T01-basic.sch"/>
    <include href="parts/PEPPOL-M-T01.sch"/>

</schema>
