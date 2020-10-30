/* global $ */
$(function () {
    'use strict';

    function createGrid() {
        $('#grid').kendoGrid({
            dataSource: {
                transport: {
                    read: config.readURL
                },
                schema: {
                    data: config.data
                }                
            },
            navigatable: true,
            filterable: true,
            height: 400,
            groupable: true,
            reorderable: true,
            resizable: true,
            sortable: true,
            pageable: {
                refresh: true
            },
            columns: config.fields
        });
    }

    createGrid();
});
