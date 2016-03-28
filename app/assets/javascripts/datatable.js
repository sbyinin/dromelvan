// TODO: DRY the datatable intialization for ajax/DOM tables.
jQuery(function() {
    var breakpointDefinition, domTableElement, responsiveHelper, tableElement;
    responsiveHelper = undefined;
    breakpointDefinition = {
        tablet: 768,
        phone_landscape: 480,
        phone: 320
    };

    tableElement = $(".data-table-ajax");
    tableElement.dataTable({
        // Uncomment this to show 'Processing' message when processing.
        // processing: true,
        pagingType: "simple_numbers",
        autoWidth: false,
        filter: (tableElement.data("hide-controls") == null) || !tableElement.data("hide-controls"),
        info: (tableElement.data("hide-controls") == null) || !tableElement.data("hide-controls"),
        lengthChange: (tableElement.data("hide-controls") == null) || !tableElement.data("hide-controls"),
        //paginate: (tableElement.data("hide-controls") == null) || !tableElement.data("hide-controls"),
        oLanguage: {
            "sLengthMenu": "Display _MENU_ " + tableElement.data("objects") + " per page.",
            "sZeroRecords": "No matching " + tableElement.data("objects") + " found.",
            "sInfo": "Showing _START_ to _END_ of _TOTAL_ " + tableElement.data("objects") + ".",
            "sInfoFiltered": "(Filtered from _MAX_ total " + tableElement.data("objects") + ")",
            "sInfoEmpty": "Showing 0 " + tableElement.data("objects") + ".",
            "sSearch": "Filter:",
            "oPaginate": {
                "sPrevious": "&lsaquo;",
                "sNext": "&rsaquo;",
                "sFirst": "&laquo;",
                "sLast": "&raquo;"
            }
        },
        ajax: {
            url: tableElement.data("url"),
            data: function(d) {
                // Avoid RequestURITooLarge error with too many columns. Keeping this in the request makes it huge and I haven't noticed a reason to keep it yet.
                d.columns = {};
                if (typeof tableElement.dataTable().fnSettings().ajax_params === 'undefined') {
                    tableElement.dataTable().fnSettings().ajax_params = tableElement.data("ajax-params");
                }
                var ajax_params = tableElement.dataTable().fnSettings().ajax_params;
                // eval turns a string "{ foo: "bar" }" into an object { "foo": "bar" }
                ajax_params = eval("(" + ajax_params + ")");
                d.ajax_params = ajax_params;
            }
        },
        serverSide: true,
        displayLength: 25,
        fnDrawCallback: function(oSettings) {
            if(responsiveHelper) {
                responsiveHelper.respond();
            }
            initTooltip();
            if (oSettings._iDisplayLength > oSettings.fnRecordsDisplay()) {
                return $(oSettings.nTableWrapper).find(".dataTables_paginate").hide();
            } else {
                return $(oSettings.nTableWrapper).find(".dataTables_paginate").show();
            }            
        },
        rowCallback: function(nRow) {
            if(responsiveHelper) {
                responsiveHelper.createExpandIcon(nRow);
            }
            if(undefined != tableElement.data("column-classes")) {
                for (var i = 0; i < tableElement.data("column-classes").length; i++) {
                    $('td:eq(' + i + ')', nRow).addClass(tableElement.data("column-classes")[i]);
                }
            }
        },
        aoColumnDefs: [
            {
                aTargets: tableElement.data("number-columns"),
                sClass: "number-column"
            }, {
                aTargets: tableElement.data("icon-columns"),
                sClass: "icon-column"
            }
        ],
        // aoColumnDefs: [{
        //   bSortable: false,
        //   aTargets: if $(this).data("unsortable-columns") is `undefined`
        //           []
        //          else
        //           $(this).data "unsortable-columns"
        // }]
    });

    if(tableElement.data("responsive")) {
        responsiveHelper = new ResponsiveDatatablesHelper(tableElement, breakpointDefinition);
    }


    domTableElement = $(".data-table-dom");
    return domTableElement.dataTable({
        processing: true,
        pagingType: "simple_numbers",
        autoWidth: false,
        oLanguage: {
            "sLengthMenu": "Display _MENU_ " + domTableElement.data("objects") + " per page.",
            "sZeroRecords": "No matching " + domTableElement.data("objects") + " found.",
            "sInfo": "Showing _START_ to _END_ of _TOTAL_ " + domTableElement.data("objects") + ".",
            "sInfoFiltered": "(Filtered from _MAX_ total " + domTableElement.data("objects") + ")",
            "sInfoEmpty": "Showing 0 " + domTableElement.data("objects") + ".",
            "sSearch": "Filter:",
            "oPaginate": {
                "sPrevious": "&lsaquo;",
                "sNext": "&rsaquo;",
                "sFirst": "&laquo;",
                "sLast": "&raquo;"
            }
        },
        displayLength: 25,
        fnDrawCallback: function(oSettings) {
            responsiveHelper.respond();
            if (oSettings._iDisplayLength > oSettings.fnRecordsDisplay()) {
                return $(oSettings.nTableWrapper).find(".dataTables_paginate").hide();
            } else {
                return $(oSettings.nTableWrapper).find(".dataTables_paginate").show();
            }
        },
        preDrawCallback: function() {
            if (!responsiveHelper) {
                responsiveHelper = new ResponsiveDatatablesHelper(domTableElement, breakpointDefinition);
            }
            responsiveHelper.respond();
        },
        rowCallback: function(nRow) {
            responsiveHelper.createExpandIcon(nRow);
        }
    });
});

function filterDatatable(property, value, selector) {
    selector = typeof selector !== 'undefined' ? selector : ".data-table-ajax";
    $(selector).dataTable().fnSettings().ajax_params = "{'" + property + "':" + value + "}"
    $(selector).DataTable().ajax.reload();    
}
