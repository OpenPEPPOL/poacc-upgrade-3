<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" 
	xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" 
	xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" 
	xmlns:ubl="urn:oasis:names:specification:ubl:schema:xsd:ApplicationResponse-2" 
	schemaVersion="iso" queryBinding="xslt2">
		
<title>Rules for PEPPOL BIS 3.0 T77 Shopping cart</title>

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

	<pattern id="transaction_rules">

		<rule context="ubl:Catalogue">
  			<assert 
				id="EUGEN-T77-R003"
				test="(cac:ValidityPeriod/cbc:EndDate) and (number(translate(cac:ValidityPeriod/cbc:EndDate,'-','')) &gt;= number(translate(cbc:IssueDate,'-','')))" 
				flag="fatal">[EUGEN-T77-R003]-The validity period end date may not be earlier than the issue date.
			</assert>
		</rule>

		<rule context="cac:CatalogueLine">
			<assert 
				id="BII3-T77-R010"
				test="(( normalize-space(.) = 'OTH' and (../cbc:StatusReason != ' ') ) or normalize-space(.) != 'OTH') " 
				flag="fatal">[BII3-T77-R010]-Shopping cart line quantities MUST be greater than ZERO.
			</assert>
		</rule>

		<rule context="cac:RequiredItemLocationQuantity/cac:Price">
			<assert 
				id="BII3-T77-R011"
				test="number(cbc:PriceAmount) &gt;=0" 
				flag="fatal">[BII3-T77-R011]-Prices of items MUST not be negative
			</assert>
		</rule>

		<rule context="cac:Item">
			<assert 
				id="BII3-T77-R012"
				test="cac:SellersItemIdentification or cac:StandardItemIdentification" 
				flag="fatal">[BII3-T77-R012]-An item in a shopping cart MUST be uniquely identifiable by either "item sellers identifier" or "item standard identifier"
			</assert>
  			<assert 
				id="EUGEN-T77-R012"
				test="(count(cac:ItemSpecificationDocumentReference[cbc:DocumentTypeCode = 'main_image']) &lt;= 1)" 
				flag="fatal">[EUGEN-T77-R012]-Only one attachment may be identified as main image.
			</assert>
		</rule>
		
		<rule context="cac:CatalogueLine/cac:RequiredItemLocationQuantity">
  			<assert 
				id="EUGEN-T77-R008"
				test="(cac:Price/cbc:BaseQuantity/@unitCode) = (cac:DeliveryUnit/cbc:BatchQuantity/@unitCode) or (not(cac:Price/cbc:BaseQuantity)) or (not(cac:DeliveryUnit/cbc:BatchQuantity))" 
				flag="fatal">[EUGEN-T77-R008]-Unit code for price base quantity must be same as for batch quantity.
			</assert>
		</rule>
		
		<rule context="cac:Item/cac:AdditionalItemProperty[cbc:Name = 'ServiceIndicator']">
  			<assert 
				id="EUGEN-T77-R010"
				test="(cbc:Value = 'true' or cbc:Value = 'false')" 
				flag="fatal">[EUGEN-T77-R010]-For AdditionalItemProperties where name is ServiceIndicator the value may only be "true" or "false".
			</assert>
		</rule>

	</pattern>
	
</schema>
