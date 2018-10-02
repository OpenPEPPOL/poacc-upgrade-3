<?xml version="1.0" encoding="UTF-8"?>
<pattern xmlns="http://purl.oclc.org/dsdl/schematron">

	<rule context="cac:DocumentResponse/cac:Response">
		<assert id="PEPPOL-T111-R001"
				test="( ( not(contains(normalize-space(cbc:ResponseCode),' '))
				and contains( ' CA UQ RE ',concat(' ',normalize-space(cbc:ResponseCode),' ') ) ) ) and count(cac:Status/cbc:StatusReasonCode)>=1
				or (not(contains( ' CA UQ RE ',concat(' ',normalize-space(cbc:ResponseCode),' ') ) ) )"
				flag="fatal">If status code is one of: CA, UQ or RE then there SHALL be at a clarification code in Invoice Response.</assert>
	</rule>

	<rule context="cac:DocumentResponse/cac:Response/cac:Status/cbc:StatusReasonCode">
		<assert id="PEPPOL-T111-R002"
				test="(( normalize-space(.) = 'OTH' and (../cbc:StatusReason != ' ') ) or normalize-space(.) != 'OTH') "
				flag="warning">If Clarification code is OTH then Clarification reason SHOULD be provided.</assert>
	</rule>

</pattern>
