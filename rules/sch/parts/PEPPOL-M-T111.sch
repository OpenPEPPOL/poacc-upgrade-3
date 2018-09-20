<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" 
	xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" 
	xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" 
	xmlns:ubl="urn:oasis:names:specification:ubl:schema:xsd:ApplicationResponse-2" 
	schemaVersion="iso" queryBinding="xslt2">
		
<title>Rules for PEPPOL BIS 3.0 T111 Invoice Response</title>

<!--
	Description: Manually maintained rules.
	Version BIS3.0
	2018-SEP
	Editor: Georg Birgisson, Midran Limited
-->

  <ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
  <ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
  <ns prefix="ubl" uri="urn:oasis:names:specification:ubl:schema:xsd:ApplicationResponse-2"/>
  <ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>

	<pattern id="transactional_rules">

		<rule context="cac:DocumentResponse/cac:Response">
			<assert id="PEPPOL-T111-R001" 
				test="( ( not(contains(normalize-space(cbc:ResponseCode),' ')) and contains( ' CA UQ RE ',concat(' ',normalize-space(cbc:ResponseCode),' ') ) ) ) and count(cac:Status/cbc:StatusReasonCode)>=1 or (not(contains( ' CA UQ RE ',concat(' ',normalize-space(cbc:ResponseCode),' ') ) ) )" 
					flag="fatal">[PEPPOL-T111-R001]-IF status code is one of: CA, UQ or RE then there SHALL be at a clarification code in Invoice Response.</assert>
		</rule>
		
		<rule context="cac:DocumentResponse/cac:Response/cac:Status/cbc:StatusReasonCode">
					
			<assert id="PEPPOL-T111-R002"
					test="(( normalize-space(.) = 'OTH' and (../cbc:StatusReason != ' ') ) or normalize-space(.) != 'OTH') " 
					flag="warning">[PEPPOL-T111-R002]-If Clarification code is OTH then Clarification reason SHOULD be provided.</assert>

		</rule>

	</pattern>
</schema>