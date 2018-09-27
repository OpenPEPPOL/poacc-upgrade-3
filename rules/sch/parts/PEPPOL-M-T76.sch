<?xml version="1.0" encoding="UTF-8"?>    
    <schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:u="utils" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        schemaVersion="iso" queryBinding="xslt2">
        
        <title>Rules for PEPPOL BIS 3.0 Order response</title>

        
        <ns uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" prefix="cbc"/>
        <ns uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" prefix="cac"/>
        <ns uri="urn:oasis:names:specification:ubl:schema:xsd:OrderResponse-2" prefix="ubl-order-response"/>

        <xsl:key name="k_lineId"  match="cac:LineItem" use="cbc:ID"/>
       
        <pattern>       
            
            <let name="documentCurrencyCode" value="/ubl-order-response:OrderReponse/cbc:DocumentCurrencyCode"/>
            
         
            
            <!-- Buyer party -->
            <rule context="cac:BuyerCustomerParty/cac:Party">
                <assert id="PEPPOL-T76-R001"
                    test="cac:PartyName/cbc:Name or cac:PartyIdentification/cbc:ID"
                    flag="fatal">An order response SHALL have the buyer party official name or a buyer party identifier</assert>
            </rule>
            
            <!-- Seller party -->
            <rule context="cac:SellerSupplierParty/cac:Party">
                <assert id="PEPPOL-T76-R002"
                    test="cac:PartyName/cbc:Name or cac:PartyIdentification/cbc:ID"
                    flag="fatal">An order response SHALL have the seller party official name or a seller party identifier</assert>
            </rule>
            
            <!-- Delivery period -->
            <rule context="cac:PromisedDeliveryPeriod | cac:OrderLine/cac:LineItem/cac:PromisedDeliveryPeriod">
                <assert  id="PEPPOL-T76-R004"
                    test="(exists(cbc:EndDate) and exists(cbc:StartDate) and (cbc:EndDate) &gt;= (cbc:StartDate)) or not(exists(cbc:StartDate)) or not(exists(cbc:EndDate)) "   
                    flag="fatal">If both delivery period start date and delivery period end date are given then the end date SHALL be later or equal to the start date.</assert>
               </rule>
           
            <!-- Line level -->       
            <rule context="cac:OrderLine/cac:LineItem">     
             
                <assert id="PEPPOL-T76-R003"
                    test="count(key('k_lineId',cbc:ID)) = 1"    
                    flag="fatal">Each order response line SHALL have a document line identifier that is unique within the order. 
                </assert>  
            
            </rule>
            
            <!-- Price -->
            <rule context=" cbc:PriceAmount">      
                <assert id="PEPPOL-T76-R005"
                    test="not(@currencyID) or @currencyID = $documentCurrencyCode"
                    flag="fatal">An order reposnse SHALL be stated in a single currency</assert>
                
            </rule>
            
            

        </pattern>
  
</schema>