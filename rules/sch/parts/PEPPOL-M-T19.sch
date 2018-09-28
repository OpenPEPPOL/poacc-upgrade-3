<?xml version="1.0" encoding="UTF-8"?>    
    <schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:u="utils" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        schemaVersion="iso" queryBinding="xslt2">
        
        <title>Rules for PEPPOL BIS 3.0 Catalogue</title>

        
        <ns uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" prefix="cbc"/>
        <ns uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" prefix="cac"/>
        <ns uri="urn:oasis:names:specification:ubl:schema:xsd:Catalogue-2" prefix="ubl"/>
        <ns uri="http://www.w3.org/2001/XMLSchema" prefix="xs"/>
        <ns uri="utils" prefix="u"/>

        
 

        <pattern>       
            
            <rule context="//cac:ValidityPeriod">         
                <assert id="BII2-T19-R006"
                    test="(number(translate(cbc:StartDate,'-','')) &lt;= number(translate(cbc:EndDate,'-',''))) or (not(cbc:StartDate)) or (not(cbc:EndDate))"    
                    flag="fatal">A validity period end date MUST be later or equal to a validity period start date if both validity period end date and validity period start date are present
                </assert>             
            </rule>
    
            <rule context="//cac:ProviderParty">         
                <assert id="BII2-T19-R010"
                    test="(cac:PartyName/cbc:Name) or (cac:PartyIdentification/cbc:ID)"    
                    flag="fatal">
                    A catalogue provider MUST contain the full name or an identifier
                </assert>             
            </rule>

            <rule context="//cac:ReceiverParty">         
                <assert id="BII2-T19-R011"
                    test="(cac:PartyName/cbc:Name) or (cac:PartyIdentification/cbc:ID)"    
                    flag="fatal">
                    A catalogue receiver MUST contain the full name or an identifier
                </assert>             
            </rule>

            <rule context="//cac:SellerSupplierParty">         
                <assert id="BII2-T19-R012"
                    test="(cac:Party/cac:PartyName/cbc:Name) or (cac:Party/cac:PartyIdentification/cbc:ID)"    
                    flag="fatal">
                    A catalogue supplier MUST contain the full name or an identifier
                </assert>             
            </rule>

            <rule context="//cac:ContractorCustomerParty">         
                <assert id="BII2-T19-R013"
                    test="(cac:Party/cac:PartyName/cbc:Name) or (cac:Party/cac:PartyIdentification/cbc:ID)"    
                    flag="fatal">
                    A catalogue customer MUST contain the full name or an identifier
                </assert>             
            </rule>

            <rule context="//cac:RequiredItemLocationQuantity/cac:Price">         
                <assert id="BII2-T19-R015"
                    test="number(cbc:PriceAmount) &gt;=0"    
                    flag="fatal">
                    Prices of items MUST not be negative
                </assert>             
            </rule>

            <rule context="//cac:CatalogueLine">         
                <assert id="BII2-T19-R017"
                    test="not(cac:LineValidityPeriod) or ((cac:LineValidityPeriod/cbc:StartDate and cac:LineValidityPeriod/cbc:EndDate) and (number(translate(cac:LineValidityPeriod/cbc:StartDate,'-','')) &gt;= number(translate(/ubl:Catalogue/cac:ValidityPeriod/cbc:StartDate,'-',''))) and  (number(translate(cac:LineValidityPeriod/cbc:EndDate,'-','')) &lt;= number(translate(/ubl:Catalogue/cac:ValidityPeriod/cbc:EndDate,'-',''))))"    
                    flag="warning">
                    Catalogue line validity period MUST be within the range of the whole catalogue validity period
                </assert>             
            </rule>

            <rule context="//cac:CatalogueLine">         
                <assert id="BII2-T19-R018"
                    test="not (cac:UsabilityPeriod) or ((//cac:UsabilityPeriod/cbc:StartDate and //cac:UsabilityPeriod/cbc:EndDate) and (number(translate(//cac:UsabilityPeriod/cbc:StartDate,'-','')) &gt;= number(translate(//cac:LineValidityPeriod/cbc:StartDate,'-',''))) and  (number(translate(//cac:UsabilityPeriod/cbc:EndDate,'-','')) &lt;= number(translate(//cac:LineValidityPeriod/cbc:EndDate,'-',''))))"    
                    flag="warning">
                    Price validity period MUST be within the range of the whole catalogue line validity period
                </assert>             
            </rule>

            <rule context="//cac:Item">         
                <assert id="BII2-T19-R019"
                    test="(cbc:Name)"    
                    flag="warning">
                    An item in a catalogue line SHOULD have a name
                </assert>             
            </rule>

            <rule context="//cac:Item">         
                <assert id="BII2-T19-R020"
                    test="(cac:StandardItemIdentification/cbc:ID) or  (cac:SellersItemIdentification/cbc:ID)"    
                    flag="fatal">
                    An item in a catalogue line MUST be uniquely identifiable by at least one of the following:
                    - Catalogue Provider identifier
                    - Standard identifier	
                </assert>             
            </rule>

            <rule context="//cac:StandardItemIdentification">         
                <assert id="BII2-T19-R021"
                    test="(cbc:ID/@schemeID)"    
                    flag="warning">
                    Standard Identifiers SHOULD contain the Schema Identifier (e.g. GTIN)
                </assert>             
            </rule>

            <rule context="//cac:CommodityClassification/cbc:ItemClassificationCode">         
                <assert id="BII2-T19-R022"
                    test="(@listID)"    
                    flag="warning">
                    Classification codes SHOULD contain the Classification scheme Identifier (e.g. CPV or UNSPSC)
                </assert>             
            </rule>

            <rule context="//cac:CatalogueLine">         
                <assert id="BII2-T19-R026"
                    test="not(cbc:MinimumOrderQuantity) or number(cbc:MinimumOrderQuantity) &gt;= 0"    
                    flag="fatal">
                    Orderable quantities MUST be greater than zero
                </assert>             
            </rule>

            
            <rule context="//cac:CatalogueLine">         
                <assert id="BII2-T19-R029"
                    test="not(cbc:MaximumOrderQuantity) or number(cbc:MaximumOrderQuantity) &gt;= 0"    
                    flag="warning">
                    Maximum quantity MUST be greater than zero
                </assert>             
            </rule>

            <rule context="//cac:CatalogueLine">         
                <assert id="BII2-T19-R030"
                    test="not(cbc:MinimumOrderQuantity) or number(cbc:MinimumOrderQuantity) &gt;= 0"    
                    flag="warning">
                    Minimum quantity MUST be greater than zero
                </assert>             
            </rule>

            <rule context="//cac:CatalogueLine">         
                <assert id="BII2-T19-R031"
                    test="not(cbc:MaximumOrderQuantity) or not(cbc:MinimumOrderQuantity) or number(cbc:MaximumOrderQuantity) &gt;= number(cbc:MinimumOrderQuantity)"    
                    flag="warning">
                    Maximum quantity MUST be greater or equal to the Minimum quantity
                </assert>             
            </rule>
               
   
        </pattern>

        
  
    
</schema>