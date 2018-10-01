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

    <let name="CatalogueValidityStart" value="number(translate(/ubl:Catalogue/cac:ValidityPeriod/cbc:StartDate,'-',''))"/>
    <let name="CatalogueValidityEnd" value="number(translate(/ubl:Catalogue/cac:ValidityPeriod/cbc:EndDate,'-',''))"/>

    <rule context="cac:CatalogueLine">
        <assert id="PEPPOL-T19-R007"
                test="not(cac:LineValidityPeriod)
                or ( cac:LineValidityPeriod/cbc:StartDate
                and cac:LineValidityPeriod/cbc:EndDate)
                and (number(translate(cac:LineValidityPeriod/cbc:StartDate,'-','')) &gt;= $CatalogueValidityStart)
                and  (number(translate(cac:LineValidityPeriod/cbc:EndDate,'-','')) &lt;= $CatalogueValidityEnd)"
                flag="warning">Catalogue line validity period SHALL be within the range of the whole catalogue validity period</assert>

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

    <rule context="cac:CatalogueLine/cac:Price">
        <assert id="PEPPOL-T19-R011"
                test="not (cac:ValidityPeriod)
                or (cac:ValidityPeriod/cbc:StartDate
                and cac:ValidityPeriod/cbc:EndDate)
                and (number(translate(cac:ValidityPeriod/cbc:StartDate,'-','')) &gt;= $CatalogueValidityStart)
                and  (number(translate(//cac:Price/cac:ValidityPeriod/cbc:EndDate,'-','')) &lt;= $CatalogueValidityEnd)"
                flag="warning">Price validity period SHALL be within the range of the whole catalogue line validity period</assert>
    </rule>

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

