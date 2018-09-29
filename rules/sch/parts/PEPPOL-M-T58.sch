<?xml version="1.0" encoding="UTF-8"?>    
<pattern xmlns="http://purl.oclc.org/dsdl/schematron">

    <rule context="cac:SenderParty">
        <assert id="BII2-T58-R007"
            test="(cac:PartyName/cbc:Name) or (cac:PartyIdentification/cbc:ID)"
            flag="fatal">
            A catalogue response sending party SHALL contain the full name or an identifier
        </assert>
    </rule>

    <rule context="cac:ReceiverParty">
        <assert id="BII2-T58-R008"
            test="(cac:PartyName/cbc:Name) or (cac:PartyIdentification/cbc:ID)"
            flag="fatal">
            A catalogue response receiving party SHALL contain the full name or an identifier
        </assert>
    </rule>

</pattern>