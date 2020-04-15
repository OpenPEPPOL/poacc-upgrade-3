<?xml version="1.0" encoding="UTF-8"?>
<pattern xmlns="http://purl.oclc.org/dsdl/schematron">

	<rule>
		<assert id="PEPPOL-T71-R001" 
				test="starts-with(normalize-space(cbc:CustomizationID/text()), 'urn:fdc:peppol.eu:poacc:trns:mlr:3')" 
				flag="fatal">Specification identifier SHALL start with the value 'urn:fdc:peppol.eu:poacc:trns:mlr:3'.</assert>
	</rule>

</pattern>

