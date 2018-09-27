<?xml version="1.0" encoding="UTF-8"?>    
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:u="utils" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        schemaVersion="iso" queryBinding="xslt2">

	<title>Rules for PEPPOL BIS 3.0 Order Agreement</title>


	<ns prefix="cbc" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"/>
	<ns prefix="cac" uri="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"/>
	<ns prefix="ubl" uri="urn:oasis:names:specification:ubl:schema:xsd:OrderResponse-2"/>
	<ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
	<ns uri="urn:un:unece:uncefact:documentation:2" prefix="ccts"/>

	<function xmlns="http://www.w3.org/1999/XSL/Transform" name="u:twodec">
		<param name="val"/>
		<value-of select="round($val * 100) div 100"/>
	</function>

	<pattern id="business_rules">

		<let name="documentCurrencyCode" value="/ubl-order:Order/cbc:DocumentCurrencyCode"/>
		<rule context="cac:Price">
			<assert id="PEPPOL-T110-R001"
                    test="number(cbc:PriceAmount) &gt;=0"    
                    flag="fatal">Prices of items SHALL not be negative.
			</assert>   
		</rule>
		<rule context="cac:Item">
			<assert id= "PEPPOL-T110-R002"
                    test="(cac:StandardItemIdentification/cbc:ID) or  (cac:SellersItemIdentification/cbc:ID)"
                    flag="fatal">Each item in an Order agreement line SHALL be identifiable by either “item sellers identifier” or “item standard identifier”                 
			</assert>
			<assert id= "PEPPOL-T110-R003"
                    test="(cbc:Name)"
                    flag="fatal">Each Order agreement line SHALL contain the item name                 
			</assert>
		</rule>   
		<rule context="cbc:Amount | cbc:TaxAmount | cbc:TaxableAmount | cbc:LineExtensionAmount | cbc:PriceAmount | cbc:BaseAmount | cac:LegalMonetaryTotal/cbc:*">      
			<assert id="PEPPOL-T110-R004"
                    test="not(@currencyID) or @currencyID = $documentCurrencyCode"
                    flag="fatal">All amounts SHALL have same currency code as document currency</assert>
		</rule>

		<rule context="cac:LegalMonetaryTotal">

			<let name="lineExtensionAmount" value="xs:decimal(if (cbc:LineExtensionAmount) then cbc:LineExtensionAmount else 0)"/>
			<let name="allowanceTotalAmount" value="xs:decimal(if (cbc:AllowanceTotalAmount) then cbc:AllowanceTotalAmount else 0)"/>
			<let name="chargeTotalAmount" value="xs:decimal(if (cbc:ChargeTotalAmount) then cbc:ChargeTotalAmount else 0)"/>
			<let name="taxExclusiveAmount" value="xs:decimal(if (cbc:TaxExclusiveAmount) then cbc:TaxExclusiveAmount else 0)"/>
			<let name="taxInclusiveAmount" value="xs:decimal(if (cbc:TaxInclusiveAmount) then cbc:TaxInclusiveAmount else 0)"/>
			<let name="payableRoundingAmount" value="xs:decimal(if (cbc:PayableRoundingAmount) then cbc:PayableRoundingAmount else 0)"/>
			<let name="payableAmount" value="xs:decimal(if (cbc:PayableAmount) then cbc:PayableAmount else 0)"/>
			<let name="prepaidAmount" value="xs:decimal(if (cbc:PrepaidAmount) then cbc:PrepaidAmount else 0)"/>


			<let name="taxTotal" value="xs:decimal(if (/ubl:OrderResponse/cac:TaxTotal/cbc:TaxAmount) then (/ubl:OrderResponse/cac:TaxTotal/cbc:TaxAmount) else 0)"/>
			<let name="allowanceTotal" value="xs:decimal(sum(/ubl:OrderResponse/cac:AllowanceCharge[cbc:ChargeIndicator='false']/cbc:Amount))"/>
			<let name="chargeTotal" value="xs:decimal(sum(/ubl:OrderResponse/cac:AllowanceCharge[cbc:ChargeIndicator='true']/cbc:Amount))"/>
			<let name="lineExtensionTotal" value="xs:decimal(sum(//cac:OrderLine/cac:LineItem/cbc:LineExtensionAmount))"/>


			<assert id="PEPPOL-T110-R005"
              test="not(cbc:PayableAmount) or cbc:PayableAmount &gt;= 0"
              flag="fatal">Total amount for payment SHALL NOT be negative, if expected total amount for payment is provided.</assert>

			<assert id="PEPPOL-T110-R006"
              test="$lineExtensionAmount &gt;= 0"
              flag="fatal">Total amount for payment SHALL NOT be negative, if expected total amount for payment is provided.</assert>

			<assert id="PEPPOL-T110-R007"
              test="not(cbc:LineExtensionAmount) or $lineExtensionAmount = u:twodec($lineExtensionTotal)"
              flag="fatal">Total sum of line amounts SHALL equal the sum of the order line amounts at order line level, if total sum of line amounts is provided.</assert>

			<assert id="PEPPOL-T110-R008"
              test="not(cbc:ChargeTotalAmount) or $chargeTotalAmount = u:twodec($chargeTotal)"
              flag="fatal">Total sum of charges at document level SHALL be equal to the sum of charges at document level, if total sum of charges at document level is provided.</assert>

			<assert id="PEPPOL-T110-R009"
              test="not(cbc:AllowanceTotalAmount) or $allowanceTotalAmount = u:twodec($allowanceTotal)"
              flag="fatal">Total sum of allowance at document level SHALL be equal to the sum of allowance amounts at document level, if total sum of allowance at document level is provided.</assert>

			<assert id="PEPPOL-T110-R010"
              test="not(cbc:TaxExclusiveAmount) or $taxExclusiveAmount = u:twodec($lineExtensionAmount) + u:twodec($chargeTotalAmount) - u:twodec($allowanceTotalAmount)"
              flag="fatal">Tax exclusive amount SHALL equal the sum of line amount plus total charge amount at document level less total allowance amount at document level if tax exclusive amount is provided.</assert>

			<assert id="PEPPOL-T110-R011"
              test="$taxInclusiveAmount = u:twodec($taxExclusiveAmount) + u:twodec($taxTotal)"
              flag="fatal">Tax inclusive amount SHALL equal tax exclusive amount plus total tax amount.</assert>

			<assert id="PEPPOL-T110-R012"
              test="not(cbc:PayableAmount) or $payableAmount = u:twodec($taxInclusiveAmount) - u:twodec($prepaidAmount) + u:twodec($payableRoundingAmount)"
              flag="fatal">Total amount for payment SHALL be equal to the tax inclusive amount minus the prepaid amount plus rounding amount</assert>

		</rule>

		<rule context="cac:AllowanceCharge">      
			<assert id="PEPPOL-T110-R013"
                    test="not(cbc:Amount) or cbc:Amount &gt; 0"
                    flag="fatal">Allowance/Charge amounts SHALL NOT be negative</assert>
		</rule>

	</pattern>
</schema>