[{assign var="i" value=1}]
[{assign var="repeat" value=true}]
[{assign var="aVisitorData" value=$oxcmp_basket->getVisitorData()}]
[{while var="repeat"}]
    <div class="visitorBox">
        <h2>[{$i++}]. Teilnehmer</h2>
        <label for="fname[{$i}]">Vor- / Nachname:</label>
        <input type="text" id="fname[{$i}]" name="persparam[[{$i}]][fname]" value="[{$aVisitorData.$i.fname}]" />
        [{* <label for="lname[{$i}]">Nachname:</label>*}]
        <input type="text" id="lname[{$i}]" name="persparam[[{$i}]][lname]" value="[{$aVisitorData.$i.lname}]" />
        <label for="twitter[{$i}]">Twitter:</label>
        <input type="text" id="twitter[{$i}]" name="persparam[[{$i}]][twitter]" value="[{$aVisitorData.$i.twitter}]" />
        <label for="position[{$i}]">Position:</label>
        <input type="text" id="position[{$i}]" name="persparam[[{$i}]][position]" value="[{$aVisitorData.$i.position}]" />
        <label for="topics[{$i}]">Vorttragsthemen:</label>
        <input type="text" id="topics[{$i}]" name="persparam[[{$i}]][topics]" value="[{$aVisitorData.$i.topics}]" />
        <label for="t-shirt[{$i}]">T-Shirt:</label>
        <select id="tshirt[{$i}]" name="persparam[[{$i}]][tshirt]">
            <option value="S" [{if $aVisitorData.$i.tshirt == 'S'}]selected="selected"[{/if}]>S</option>
            <option value="M" [{if $aVisitorData.$i.tshirt == 'M'}]selected="selected"[{/if}]>M</option>
            <option value="L" [{if $aVisitorData.$i.tshirt == 'L'}]selected="selected"[{/if}]>L</option>
            <option value="XL" [{if $aVisitorData.$i.tshirt == 'XL'}]selected="selected"[{/if}]>XL</option>
        </select>
        <label for="system[{$i}]">Shopsystem:</label>
        <select id="system[{$i}]" name="persparam[[{$i}]][system]">
            <option value="not defined" [{if $aVisitorData.$i.system == 'not defined'}]selected="selected"[{/if}]>bitte wählen</option>
            <option value="Magento" [{if $aVisitorData.$i.system == 'Magento'}]selected="selected"[{/if}]>Magento</option>
            <option value="OXID" [{if $aVisitorData.$i.system == 'OXID'}]selected="selected"[{/if}]>OXID</option>
            <option value="osCommerce" [{if $aVisitorData.$i.system == 'osCommerce'}]selected="selected"[{/if}]>osCommerce</option>
            <option value="Shopware" [{if $aVisitorData.$i.system == 'Shopware'}]selected="selected"[{/if}]>Shopware</option>
            <option value="XTCommerce" [{if $aVisitorData.$i.system == 'XTCommerce'}]selected="selected"[{/if}]>XTCommerce</option>
            <option value="anderes" [{if $aVisitorData.$i.system == 'anderes'}]selected="selected"[{/if}]>Anderes</option>
        </select>
            [{if $i > $oxcmp_basket->getTicketCount()}]
                [{assign var="repeat" value=false}]
            [{/if}]
    </div>
[{/while}]