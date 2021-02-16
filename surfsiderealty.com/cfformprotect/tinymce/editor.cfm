<script type="text/javascript" src="/mls/backend/tinymce/tinymce.min.js"></script>



<script type="text/javascript">
    tinymce.init({
        selector: "textarea:not(.mceNoEditor)",
        height: 200,
        width: 700,
        plugins: [
                "filemanager advlist autolink autosave link image lists charmap preview hr anchor pagebreak spellchecker",
                "searchreplace wordcount code fullscreen insertdatetime nonbreaking",
                "table contextmenu directionality template textcolor paste textcolor colorpicker textpattern"
        ],

        toolbar1: "bold italic underline strikethrough | alignleft aligncenter alignright alignjustify | styleselect formatselect fontselect fontsizeselect",
        toolbar2: "cut copy paste | searchreplace | bullist numlist | outdent indent | undo redo | link unlink anchor image filemanager code | preview | forecolor",
        toolbar3: "table | hr removeformat | fullscreen | spellchecker | nonbreaking template pagebreak",

        menubar: false,
        toolbar_items_size: 'small',

        style_formats: [
                {title: 'Bold text', inline: 'b'},
                {title: 'Red text', inline: 'span', styles: {color: '#ff0000'}},
                {title: 'Red header', block: 'h1', styles: {color: '#ff0000'}},
                {title: 'Example 1', inline: 'span', classes: 'example1'},
                {title: 'Example 2', inline: 'span', classes: 'example2'},
                {title: 'Table styles'},
                {title: 'Table row 1', selector: 'tr', classes: 'tablerow1'}
        ],

        templates: [
                {title: 'Test template 1', content: 'Test 1'},
                {title: 'Test template 2', content: 'Test 2'}
        ],
        extended_valid_elements:'script[language|type|src]'
});

  </script>
