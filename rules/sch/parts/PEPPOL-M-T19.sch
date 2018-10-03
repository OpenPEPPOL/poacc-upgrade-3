<?xml version="1.0" encoding="UTF-8"?>
<pattern xmlns="http://purl.oclc.org/dsdl/schematron">

    <rule context="cac:ValidityPeriod">
        <assert id="PEPPOL-T19-R001"
                test="(number(translate(cbc:StartDate,'-','')) &lt;= number(translate(cbc:EndDate,'-',''))) or (not(cbc:StartDate)) or (not(cbc:EndDate))"
                flag="fatal">A validity period end date SHALL be later or equal to a validity period start date if both validity period end date and validity period start date are present</assert>
    </rule>

    <rule context="cac:ProviderParty">
        <assert id="PEPPOL-T19-R002"
                test="(cac:PartyName/cbc:Name) or (cac:PartyIdentification/cbc:ID)"
                flag="fatal">A catalogue provider SHALL contain the full name or an identifier</assert>
    </rule>

    <rule context="cac:ReceiverParty">
        <assert id="PEPPOL-T19-R003"
                test="(cac:PartyName/cbc:Name) or (cac:PartyIdentification/cbc:ID)"
                flag="fatal">A catalogue receiver SHALL contain the full name or an identifier</assert>
    </rule>

    <rule context="cac:SellerSupplierParty">
        <assert id="PEPPOL-T19-R004"
                test="(cac:Party/cac:PartyName/cbc:Name) or (cac:Party/cac:PartyIdentification/cbc:ID)"
                flag="fatal">A catalogue supplier SHALL contain the full name or an identifier</assert>
    </rule>

    <rule context="cac:ContractorCustomerParty">
        <assert id="PEPPOL-T19-R005"
                test="(cac:Party/cac:PartyName/cbc:Name) or (cac:Party/cac:PartyIdentification/cbc:ID)"
                flag="fatal">A catalogue customer SHALL contain the full name or an identifier</assert>
    </rule>

    <rule context="cac:RequiredItemLocationQuantity/cac:Price">
        <assert id="PEPPOL-T19-R006"
                test="number(cbc:PriceAmount) &gt;=0"
                flag="fatal">Prices of items SHALL not be negative</assert>
    </rule>

	<let name="CatalogueValidityStart" 
		value="if(exists(/ubl:Catalogue/cac:ValidityPeriod/cbc:StartDate)) then number(translate(/ubl:Catalogue/cac:ValidityPeriod/cbc:StartDate,'-','')) else 0"/>
    <let name="CatalogueValidityEnd" 
		value="if(exists(/ubl:Catalogue/cac:ValidityPeriod/cbc:EndDate)) then number(translate(/ubl:Catalogue/cac:ValidityPeriod/cbc:EndDate,'-','')) else 99999999"/>
    
    <let name="CatalogueLineValidityStart" 
		value="if(exists(cac:CatalogueLine/cac:LineValidityPeriod/cbc:StartDate)) then number(translate(cac:CatalogueLine/cac:LineValidityPeriod/cbc:StartDate,'-','')) else $CatalogueValidityStart"/>
	<let name="CatalogueLineValidityEnd" 
		value="if(exists(cac:CatalogueLine/cac:LineValidityPeriod/cbc:EndDate)) then number(translate(cac:CatalogueLine/cac:LineValidityPeriod/cbc:EndDate,'-','')) else $CatalogueValidityEnd"/>

	<rule context="cac:CatalogueLine/cac:LineValidityPeriod">
      
        <assert id="PEPPOL-T19-R007"
            test="($CatalogueLineValidityStart &gt;= $CatalogueValidityStart) and ($CatalogueLineValidityStart &lt;= $CatalogueValidityEnd) 
            and ($CatalogueLineValidityEnd &lt;= $CatalogueValidityEnd) and ($CatalogueLineValidityEnd &gt;= $CatalogueValidityStart)"        
                flag="fatal">Catalogue line validity period SHALL be within the range of the whole catalogue validity period</assert>
        <assert id="PEPPOL-T19-R013"
            test="($CatalogueLineValidityStart &lt;= $CatalogueLineValidityEnd)"
            flag="fatal">A line validity period end date SHALL be later or equal to the line validity period start date
        </assert>
    </rule>
	
    <rule context="cac:CatalogueLine">
        <assert id="PEPPOL-T19-R008"
                test="not(cbc:MaximumOrderQuantity) or number(cbc:MaximumOrderQuantity) &gt;= 0"
                flag="fatal">Maximum quantity SHALL be greater than zero</assert>

        <assert id="PEPPOL-T19-R009"
                test="not(cbc:MinimumOrderQuantity) or number(cbc:MinimumOrderQuantity) &gt;= 0"
                flag="fatal">Minimum quantity SHALL be greater than zero</assert>

        <assert id="PEPPOL-T19-R010"
                test="not(cbc:MaximumOrderQuantity) or not(cbc:MinimumOrderQuantity) or number(cbc:MaximumOrderQuantity) &gt;= number(cbc:MinimumOrderQuantity)"
                flag="fatal">Maximum quantity SHALL be greater or equal to the Minimum quantity</assert>
    </rule>

    <rule context="cac:ClassifiedTaxCategory">
        <assert id="PEPPOL-T19-R014"
            test="cbc:Percent or (normalize-space(cbc:ID)='O')"
            flag="fatal">Each Tax Category SHALL have a VAT category rate, except if the catalogue line is not subject to VAT.</assert>
        <assert id="PEPPOL-T19-R015"
            test="not(normalize-space(cbc:ID)='S') or (cbc:Percent) &gt; 0"
            flag="fatal">When VAT category code is "Standard rated" (S) the VAT rate SHALL be greater than zero.</assert>
    </rule>
 
    <rule context="cac:Catalogue/cac:CatalogueLine/cac:RequiredItemLocationQuantity/cac:Price/cac:ValidityPeriod">
      
 		<let name="PriceValidityStart" value="if(exists(cbc:StartDate)) then number(translate(cbc:StartDate,'-','')) else $CatalogueLineValidityStart"/>
        <let name="PriceValidityEnd" value="if(exists(cbc:EndDate)) then number(translate(cbc:EndDate,'-','')) else $CatalogueLineValidityEnd"/>
        
        <assert id="PEPPOL-T19-R011"
            test="($PriceValidityStart &gt;= $CatalogueLineValidityStart) and ($PriceValidityStart &lt;= $CatalogueLineValidityStart) 
            and ($PriceValidityEnd &lt;= $CatalogueLineValidityEnd) and ($PriceValidityEnd &gt;= $CatalogueLineValidityEnd)"        
                flag="fatal">Catalogue line validity period SHALL be within the range of the whole catalogue validity period</assert>
        <assert id="PEPPOL-T19-R016"
            test="($PriceValidityStart &lt;= $PriceValidityEnd)"
            flag="fatal">A line validity period end date SHALL be later or equal to the line validity period start date
        </assert>
    </rule>
 
    <!-- <rule context="cac:CatalogueLine/cac:Price/cac:ValidityPeriod">
                <let name="CatalogueLineValidityStart" value="if(ubl:Catalogue/cac:CatalogueLine/cac:LineValidityPeriod/cbc:StartDate) then number(translate(/ubl:Catalogue/cac:CatalogueLine/cac:LineValidityPeriod/cbc:StartDate,'-','')) else '0001-01-01'"/>
                <let name="CatalogueLineValidityEnd" value="if(ubl:Catalogue/cac:CatalogueLine/cac:LineValidityPeriod/cbc:EndDate) then number(translate(/ubl:Catalogue/cac:CatalogueLine/cac:LineValidityPeriod/cbc:EndDate,'-','')) else '9999-12-31'"/>

        <assert id="PEPPOL-T19-R011"
                test="(not(cbc:StartDate) or ((number(translate(cbc:StartDate,'-','')) &gt;= $CatalogueValidityStart) and (number(translate(cbc:StartDate,'-','')) &lt;= $CatalogueValidityEnd)))
                and (not(cbc:EndDate) or ((number(translate(cbc:EndDate,'-','')) &lt;= $CatalogueValidityEnd) and (number(translate(cbc:EndDate,'-','')) &gt;= $CatalogueValidityStart)))
                and (not(cbc:StartDate) or not(cbc:EndDate) or xs:date(cbc:StartDate) &lt;= xs:date(cbc:EndDate))"
                flag="warning">Catalogue line validity period SHALL be within the range of the whole catalogue validity period</assert>
    </rule> -->

    <rule context="cac:Item">
        <assert id="PEPPOL-T19-R012"
                test="(cac:StandardItemIdentification/cbc:ID) or (cac:SellersItemIdentification/cbc:ID)"
                flag="fatal">Each item in a Catalogue SHALL be identifiable by either “item sellers identifier” or “item standard identifier”</assert>
    </rule>

    <!-- <rule context="cac:StandardItemIdentification">
    GB: Rule removed because @schemaID is already mandated in the structure and that is in line with catalogue.
        <assert id="PEPPOL-T19-R011"
                test="(cbc:ID/@schemeID)"
                flag="warning">Standard Identifiers SHOULD contain the Schema Identifier (e.g. GTIN)</assert>
    </rule> -->

    <!-- <rule context="cac:CommodityClassification/cbc:ItemClassificationCode">
    GB: Rule removed. attribute is made mandatory in struture in line with invoice.
        <assert id="PEPPOL-T19-R012"
                test="(@listID)"
                flag="warning">Classification codes SHOULD contain the Classification scheme Identifier (e.g. CPV or UNSPSC)</assert>
    </rule> -->

    <!--Change rule to cover quantities. GB: This rule is not correct. Orderable quantitiy is not used in catalogue. Rule removed.-->
    <!-- <rule context="cac:CatalogueLine">
        <assert id="PEPPOL-T19-R026"
                test="not(cbc:MinimumOrderQuantity) or number(cbc:MinimumOrderQuantity) &gt;= 0"
                flag="fatal">Orderable quantities SHALL be greater than zero</assert>
    </rule> -->

    <!--Change text. GB: Item name made mandatory in syntax-->
    <!-- <rule context="cac:Item">
        <assert id="PEPPOL-T19-R009"
                test="(cbc:Name)"
                flag="fatal">An item in a catalogue line SHALL have a name</assert>
    </rule> -->

    <!--Change text-->

    <!--Delete rule??-->

</pattern>
