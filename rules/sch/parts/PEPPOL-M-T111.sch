<?xml version="1.0" encoding="UTF-8"?>
<pattern xmlns="http://purl.oclc.org/dsdl/schematron">

	<rule context="cac:Response[contains( ' CA UQ RE ',concat(' ',normalize-space(cbc:ResponseCode),' '))]">
		<assert id="PEPPOL-T111-R001"
			test="exists(cac:Status/cbc:StatusReasonCode)"
				flag="fatal">If status code is one of: CA, UQ or RE then there SHALL be at a clarification code in Invoice Response.</assert>
	</rule>

	<rule context="cac:Status[cbc:StatusReasonCode='OTH']">
		<assert id="PEPPOL-T111-R002"
				test="exists(cbc:StatusReason)"
				flag="warning">If Clarification code is OTH then Clarification reason SHOULD be provided.</assert>
	</rule>

</pattern>

