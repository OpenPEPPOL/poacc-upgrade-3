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

    <rule context="cac:CatalogueLine">
        <assert id="PEPPOL-T19-R007"
                test="not(cac:LineValidityPeriod) or ((cac:LineValidityPeriod/cbc:StartDate and cac:LineValidityPeriod/cbc:EndDate) and (number(translate(cac:LineValidityPeriod/cbc:StartDate,'-','')) &gt;= number(translate(/ubl:Catalogue/cac:ValidityPeriod/cbc:StartDate,'-',''))) and  (number(translate(cac:LineValidityPeriod/cbc:EndDate,'-','')) &lt;= number(translate(/ubl:Catalogue/cac:ValidityPeriod/cbc:EndDate,'-',''))))"
                flag="warning">Catalogue line validity period SHALL be within the range of the whole catalogue validity period</assert>
    </rule>

    <rule context="cac:CatalogueLine">
        <assert id="PEPPOL-T19-R008"
                test="not (cac:Price/cac:ValidityPeriod) or ((//cac:Price/cac:ValidityPeriod/cbc:StartDate and //cac:Price/cac:ValidityPeriod/cbc:EndDate) and (number(translate(//cac:Price/cac:ValidityPeriod/cbc:StartDate,'-','')) &gt;= number(translate(//cac:LineValidityPeriod/cbc:StartDate,'-',''))) and  (number(translate(//cac:Price/cac:ValidityPeriod/cbc:EndDate,'-','')) &lt;= number(translate(//cac:LineValidityPeriod/cbc:EndDate,'-',''))))"
                flag="warning">Price validity period SHALL be within the range of the whole catalogue line validity period</assert>
    </rule>

    <!--Change text-->
    <rule context="cac:Item">
        <assert id="PEPPOL-T19-R009"
                test="(cbc:Name)"
                flag="fatal">An item in a catalogue line SHALL have a name</assert>
    </rule>

    <!--Change text-->
    <rule context="cac:Item">
        <assert id="PEPPOL-T19-R010"
                test="(cac:StandardItemIdentification/cbc:ID) or  (cac:SellersItemIdentification/cbc:ID)"
                flag="fatal">
                An item in a catalogue line SHALL be uniquely identifiable by at least one of the following:
                - Catalogue Provider identifier
                - Standard identifier</assert>
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

    <!--Change rule to cover quantities-->
    <rule context="cac:CatalogueLine">
        <assert id="PEPPOL-T19-R013"
                test="not(cbc:MinimumOrderQuantity) or number(cbc:MinimumOrderQuantity) &gt;= 0"
                flag="fatal">Orderable quantities SHALL be greater than zero</assert>
    </rule>

    <!--Delete rule??-->
    <rule context="cac:CatalogueLine">
        <assert id="BII2-T19-R029"
                test="not(cbc:MaximumOrderQuantity) or number(cbc:MaximumOrderQuantity) &gt;= 0"
                flag="warning">Maximum quantity SHALL be greater than zero</assert>
    </rule>
    <!--Delete rule??-->
    <rule context="cac:CatalogueLine">
        <assert id="BII2-T19-R030"
                test="not(cbc:MinimumOrderQuantity) or number(cbc:MinimumOrderQuantity) &gt;= 0"
                flag="warning">Minimum quantity SHALL be greater than zero</assert>
    </rule>

    <!--Change rule ID if prior rules are deleted-->
    <rule context="cac:CatalogueLine">
        <assert id="PEPPOL-T19-R016"
                test="not(cbc:MaximumOrderQuantity) or not(cbc:MinimumOrderQuantity) or number(cbc:MaximumOrderQuantity) &gt;= number(cbc:MinimumOrderQuantity)"
                flag="warning">Maximum quantity SHALL be greater or equal to the Minimum quantity</assert>
    </rule>

</pattern>
