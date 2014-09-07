# TODO: DRY the datatable intialization for ajax/DOM tables.
jQuery ->
  responsiveHelper = `undefined`
  breakpointDefinition =
    tablet: 768
    phone_landscape: 480
    phone: 320

  tableElement = $(".data-table-ajax")
  tableElement.dataTable
        # Uncomment this to show 'Processing' message when processing.
        #processing: true
        pagingType: "simple_numbers"
        autoWidth: false
        oLanguage: {
          "sLengthMenu": "Display _MENU_ " + tableElement.data("objects") + " per page.",
          "sZeroRecords": "No matching " + tableElement.data("objects") + " found."
          "sInfo": "Showing _START_ to _END_ of _TOTAL_ " + tableElement.data("objects") + ".",
          "sInfoFiltered": "(Filtered from _MAX_ total " + tableElement.data("objects") + ")"
          "sInfoEmpty": "Showing 0 " + tableElement.data("objects") + ".",
          "sSearch": "Filter:",
          
          "oPaginate": {
            "sPrevious": "&lsaquo;",
            "sNext": "&rsaquo;",
            "sFirst": "&laquo;",
            "sLast": "&raquo;"
          }
        }
         
        ajax:
          url: tableElement.data("url")
          
        serverSide: true
        displayLength: 25
        
        fnDrawCallback: (oSettings) ->
          responsiveHelper.respond()
          if oSettings._iDisplayLength > oSettings.fnRecordsDisplay()
             $(oSettings.nTableWrapper).find(".dataTables_paginate").hide()
           else
             $(oSettings.nTableWrapper).find(".dataTables_paginate").show()
             
        preDrawCallback: ->      
          # Initialize the responsive datatables helper once.
          responsiveHelper = new ResponsiveDatatablesHelper(tableElement, breakpointDefinition)  unless responsiveHelper
          responsiveHelper.respond()
          return
      
        rowCallback: (nRow) ->
          responsiveHelper.createExpandIcon nRow
          return
        
        #aoColumnDefs: [{
        #  bSortable: false,
        #  aTargets: if $(this).data("unsortable-columns") is `undefined`
        #              []
        #            else
        #              $(this).data "unsortable-columns"
        #}]
  

  tableElement = $(".data-table-dom")
  tableElement.dataTable
        # Uncomment this to show 'Processing' message when processing.
        processing: true
        pagingType: "simple_numbers"
        autoWidth: false
        oLanguage: {
          "sLengthMenu": "Display _MENU_ " + tableElement.data("objects") + " per page.",
          "sZeroRecords": "No matching " + tableElement.data("objects") + " found."
          "sInfo": "Showing _START_ to _END_ of _TOTAL_ " + tableElement.data("objects") + ".",
          "sInfoFiltered": "(Filtered from _MAX_ total " + tableElement.data("objects") + ")"
          "sInfoEmpty": "Showing 0 " + tableElement.data("objects") + ".",
          "sSearch": "Filter:",
          
          "oPaginate": {
            "sPrevious": "&lsaquo;",
            "sNext": "&rsaquo;",
            "sFirst": "&laquo;",
            "sLast": "&raquo;"
          }
        }
         
        displayLength: 25
        
        fnDrawCallback: (oSettings) ->
          responsiveHelper.respond()
          if oSettings._iDisplayLength > oSettings.fnRecordsDisplay()
             $(oSettings.nTableWrapper).find(".dataTables_paginate").hide()
           else
             $(oSettings.nTableWrapper).find(".dataTables_paginate").show()
             
        preDrawCallback: ->      
          # Initialize the responsive datatables helper once.
          responsiveHelper = new ResponsiveDatatablesHelper(tableElement, breakpointDefinition)  unless responsiveHelper
          responsiveHelper.respond()
          return
      
        rowCallback: (nRow) ->
          responsiveHelper.createExpandIcon nRow
          return
        
        #aoColumnDefs: [{
        #  bSortable: false,
        #  aTargets: if $(this).data("unsortable-columns") is `undefined`
        #              []
        #            else
        #              $(this).data "unsortable-columns"
        #}]
