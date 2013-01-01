[{assign var="i" value=1}]
[{assign var="repeat" value=true}]
[{while var="repeat"}]
    <div class="visitorBox">
        <h2>[{$i++}]. Teilnehmer</h2>

        <label for="fname[{$i}]">Vorname:</label>
        <input type="text" id="fname[{$i}]" name="persparam[[{$i}]_fname]" />
        <label for="lname[{$i}]">Nachname:</label>
        <input type="text" id="lname[{$i}]" name="persparam[[{$i}]_lname]" />
        <label for="twitter[{$i}]">Twitter:</label>
        <input type="text" id="twitter[{$i}]" name="persparam[[{$i}]_twitter]" />
        <label for="position[{$i}]">Position:</label>
        <input type="text" id="position[{$i}]" name="persparam[[{$i}]_position]" />
        <label for="position[{$i}]">Vorttragsthemen:</label>
        <input type="text" id="topics[{$i}]" name="persparam[[{$i}]_topics]" />
        <label for="t-shirt[{$i}]">T-Shirt:</label>
        <select id="t-shirt[{$i}]" name="persparam[[{$i}]_t-shirt]">
            <option value="s">S</option>
            <option value="M">M</option>
            <option value="L">L</option>
            <option value="XL">XL</option>
        </select>
            [{if $i > $oxcmp_basket->getItemsCount()}]
                [{assign var="repeat" value=false}]
            [{/if}]
    </div>
[{/while}]