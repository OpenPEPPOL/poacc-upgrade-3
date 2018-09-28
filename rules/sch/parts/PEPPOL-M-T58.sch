<?xml version="1.0" encoding="UTF-8"?>    
    <schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:u="utils" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        schemaVersion="iso" queryBinding="xslt2">
        
        <title>Rules for PEPPOL BIS 3.0 Catalogue Response</title>

        
        <ns uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" prefix="cbc"/>
        <ns uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" prefix="cac"/>
        <ns uri="urn:oasis:names:specification:ubl:schema:xsd:ApplicationResponse-2" prefix="ubl-apprep"/>
        <ns uri="http://www.w3.org/2001/XMLSchema" prefix="xs"/>
        <ns uri="utils" prefix="u"/>

        
        <!-- tag::functions[] -->
        <!-- Functions -->
        
        <function xmlns="http://www.w3.org/1999/XSL/Transform" name="u:slack" as="xs:boolean">
            <param name="exp" as="xs:decimal"/>
            <param name="val" as="xs:decimal"/>
            <param name="slack" as="xs:decimal"/>
            <value-of select="xs:decimal($exp + $slack) &gt;= $val and xs:decimal($exp - $slack) &lt;= $val"/>
        </function>
        
        <pattern>       

            <rule context="//cac:SenderParty">         
                <assert id="BII2-T58-R007"
                    test="(cac:PartyName/cbc:Name) or (cac:PartyIdentification/cbc:ID)"    
                    flag="fatal">
                    A catalogue response sending party SHALL contain the full name or an identifier
                </assert>             
            </rule>
              
            <rule context="//cac:ReceiverParty">         
                <assert id="BII2-T58-R008"
                    test="(cac:PartyName/cbc:Name) or (cac:PartyIdentification/cbc:ID)"    
                    flag="fatal">
                    A catalogue response receiving party SHALL contain the full name or an identifier
                </assert>             
            </rule>
  
   
        </pattern>

        
  
    
</schema>