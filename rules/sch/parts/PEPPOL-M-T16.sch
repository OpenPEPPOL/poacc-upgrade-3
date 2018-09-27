<?xml version="1.0" encoding="UTF-8"?>    
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:u="utils" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        schemaVersion="iso" queryBinding="xslt2">

	<title>Rules for PEPPOL BIS 3.0 Despatch Advice</title>


	<ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
	<ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
	<ns prefix="ubl" uri="urn:oasis:names:specification:ubl:schema:xsd:DespatchAdvice-2"/>
	<ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
	<ns uri="urn:un:unece:uncefact:documentation:2" prefix="ccts"/>

	<phase id="BIIRULEST16_phase">
		<active pattern="UBL-T16"/>
	</phase>

	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" abstract="true" id="T16">
		<rule context="//cac:DeliveryCustomerParty">
			<assert test="(cac:Party/cac:PartyName/cbc:Name) or (cac:Party/cac:PartyIdentification/cbc:ID)" flag="warning" id="PEPPOL-T16-R001">A consignee party SHOULD have the party name or a party identifier</assert>
		</rule>
		<rule context="/ubl:DespatchAdvice">
			<assert test="(cac:OrderReference/cbc:ID)" flag="warning" id="PEPPOL-T16-R002">A despatch advice SHOULD have an order identifier</assert>
		</rule>
		<rule context="//cac:DespatchLine">
			<assert test="(cac:Item/cac:StandardItemIdentification/cbc:ID) or  (cac:Item/cac:SellersItemIdentification/cbc:ID)" flag="fatal" id="PEPPOL-T16-R003">Each item in a Despatch Advice line SHALL be identifiable by either “item sellers identifier” or “item standard identifier”</assert>
			<assert test="(cac:Item/cbc:Name)" flag="fatal" id="PEPPOL-T16-R004">Each Despatch Advice SHALL contain the item name</assert>
			<assert test="(cbc:DeliveredQuantity)" flag="warning" id="PEPPOL-T16-R005">Each despatch advice line SHOULD have a delivered quantity</assert>
			<assert test="(cbc:DeliveredQuantity) &gt;= 0" flag="fatal" id="PEPPOL-T16-R006">Each despatch advice line delivered quantity SHALL not be negative</assert>
			<assert test="((cbc:OutstandingQuantity) and (cbc:OutstandingReason)) or not(cbc:OutstandingQuantity)" flag="warning" id="PEPPOL-T16-R007">An outstanding quantity reason SHOULD be provided if the despatch line contains an outstanding quantity</assert>
		</rule>
		<rule context="//cac:DespatchSupplierParty">
			<assert test="(cac:Party/cac:PartyName/cbc:Name)" flag="warning" id="PEPPOL-T16-R008">A despatching party SHOULD have the despatching party name</assert>
		</rule>
	</pattern>


</schema>