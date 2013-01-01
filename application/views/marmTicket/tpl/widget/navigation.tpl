[{assign var="active" value=0}]
[{if $oViewConf->getActiveClassName() == "basket"}]
    [{assign var="active" value=1}]
[{elseif $oViewConf->getActiveClassName() == "user"}]
    [{assign var="active" value=2}]
[{elseif $oViewConf->getActiveClassName() == "payment"}]
    [{assign var="active" value=3}]
[{elseif $oViewConf->getActiveClassName() == "order"}]
    [{assign var="active" value=4}]
[{elseif $oViewConf->getActiveClassName() == "thankyou"}]
    [{assign var="active" value=5}]
[{/if}]


<div id="basenavigation">
    <ul>
        <li>
            <a href="[{$oViewConf->getHomeLink()}]" title="Startseite" [{if $active == 0}]class="active"[{elseif $active > 0}]class="passed"[{/if}]><strong>1.</strong><br />Tickets & Pakete</a>
        </li>
        <li>
            <a href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=basket" }]"  title="Teilnehmerdaten" [{if $active == 1}]class="active"[{elseif $active > 1}]class="passed"[{/if}]><strong>2.</strong><br />Teilnehmerdaten</a>
        </li>
        <li>
            <a href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=user" }]" title="Ihre Rechnungsdaten" [{if $active == 2}]class="active"[{elseif $active > 2}]class="passed"[{/if}]><strong>3.</strong><br />Rechnungsdaten </a>
        </li>
        <li>
            <a href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=payment" }]" title="Zahlart wählen" [{if $active == 3}]class="active"[{elseif $active > 3}]class="passed"[{/if}]><strong>4.</strong><br />Zahlungsart</a>
        </li>
        <li>
            <a href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=order" }]" title="Bestellbestätigung" [{if $active == 4}]class="active"[{elseif $active > 4}]class="passed"[{/if}]><strong>5.</strong><br />Abschluß</a>
        </li>
    </ul>
</div>
