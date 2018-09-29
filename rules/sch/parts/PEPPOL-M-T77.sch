<?xml version="1.0" encoding="UTF-8"?>
<pattern xmlns="http://purl.oclc.org/dsdl/schematron">

	<rule context="ubl:Catalogue">
		<assert
			id="EUGEN-T77-R003"
			test="(cac:ValidityPeriod/cbc:EndDate) and (number(translate(cac:ValidityPeriod/cbc:EndDate,'-','')) &gt;= number(translate(cbc:IssueDate,'-','')))"
			flag="fatal">The validity period end date may not be earlier than the issue date.</assert>
	</rule>

	<rule context="cac:CatalogueLine">
		<assert
			id="BII3-T77-R010"
			test="(( normalize-space(.) = 'OTH' and (../cbc:StatusReason != ' ') ) or normalize-space(.) != 'OTH') "
			flag="fatal">Shopping cart line quantities SHALL be greater than ZERO.</assert>
	</rule>

	<rule context="cac:RequiredItemLocationQuantity/cac:Price">
		<assert
			id="BII3-T77-R011"
			test="number(cbc:PriceAmount) &gt;=0"
			flag="fatal">Prices of items SHALL not be negative</assert>
	</rule>

	<rule context="cac:Item">
		<assert
			id="BII3-T77-R012"
			test="cac:SellersItemIdentification or cac:StandardItemIdentification"
			flag="fatal">An item in a shopping cart SHALL be uniquely identifiable by either "item sellers identifier" or "item standard identifier"</assert>
		<assert
			id="EUGEN-T77-R012"
			test="(count(cac:ItemSpecificationDocumentReference[cbc:DocumentTypeCode = 'main_image']) &lt;= 1)"
			flag="fatal">Only one attachment may be identified as main image.</assert>
	</rule>

	<rule context="cac:CatalogueLine/cac:RequiredItemLocationQuantity">
		<assert
			id="EUGEN-T77-R008"
			test="(cac:Price/cbc:BaseQuantity/@unitCode) = (cac:DeliveryUnit/cbc:BatchQuantity/@unitCode) or (not(cac:Price/cbc:BaseQuantity)) or (not(cac:DeliveryUnit/cbc:BatchQuantity))"
			flag="fatal">Unit code for price base quantity SHALL be same as for batch quantity.</assert>
	</rule>

	<rule context="cac:Item/cac:AdditionalItemProperty[cbc:Name = 'ServiceIndicator']">
		<assert
			id="EUGEN-T77-R010"
			test="(cbc:Value = 'true' or cbc:Value = 'false')"
			flag="fatal">For AdditionalItemProperties where name is ServiceIndicator the value may only be "true" or "false".</assert>
	</rule>

</pattern>
