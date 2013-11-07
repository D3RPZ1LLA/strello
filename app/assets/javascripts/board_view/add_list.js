$(document).ready(function () {
/* Render Functions */
	var renderNewList = function () {
		$('.new-list').addClass('hidden');
		$('#add-list-form').removeClass('hidden');
		$($('#add-list-form').children('input')[2]).focus();
	}
	
	var resetNewList = function () {
		$('.new-list').removeClass('hidden');
		$('#add-list-form').addClass('hidden');
	}
  
	$('.new-list').on('click', function(event) {
		renderNewList();
	});
	
	$('body').on('click', function(event) {
		var $target = $(event.target);
		
		if(
			!($target.hasClass('new-list')) &&
			!($target.is('#add-list-form')) &&
			!($target.parent().is('#add-list-form'))
		) {
			
			resetNewList();
		}
	});
	
/* Submit Functions */
	var ST = (window.ST || {});
	
	var appendList = function (data) {
		$('#new-catagory-li').before(JST['list']({
			data: data,
			form_authenticity_token: "<%= form_authenticity_token %>"
		}));
				
		var minWidth = parseInt($('.board').css('min-width').slice(0, -2));
		minWidth += 290;
		$('.board').css('min-width', minWidth);
	};
	
	$('#add-list-form').on('click', 'button', function(event) {
		event.preventDefault();
		$(this).submit();
	});
	
	$('#add-list-form').on('ajax:success', function(event, data) {		
		var $form = $(this);
		var $newCatagoryLi = $('#new-catagory-li');
		
		appendList(data);
		
		ST.sorted.sortable( "destroy" );
		
	  ST.sorted = $(".list ul").sortable({
	    connectWith: ".list ul",
			dropOnEmpty: true,
	    start: function (event, ui) {
	      // ui.item.toggleClass("highlight");
	    },
	    stop: function (event, ui) {
	      // ui.item.toggleClass("highlight");
				window.ST.reorderCards();
	    }
	  });
		
		$form[0].reset();
		$form.children('#catagory-sort-idx').val($('#board-lists').children().length - 1);
		$newCatagoryLi.detach();
		$('#board-lists').append($newCatagoryLi);
		resetNewList();
		
		reorderLists();
	});
	
	
/* Sorting Functions */
	var reorderLists = function () {
			var nonListPassed = false;
			var alteredCatagories = [];
			
			$('#board-lists').children().each(function (idx, li) {
				var $li = $(li);
				var properIdx = nonListPassed ? idx - 1: idx;
				
				if ($li.hasClass('list') && $li.data('idx') !== properIdx) {

					$li.data('idx', properIdx);
					
					alteredCatagories.push({
						id: $li.data('id'),
						sort_idx: properIdx
					});
					
				} else if ($li.is('#new-catagory-li')) {
					nonListPassed = true;
					$li.children('form').children('#catagory-sort-idx').val(idx);
				}
			});
			
			if (alteredCatagories.length > 0) {
				$.ajax({
					url: '/boards/' + $('.board').data('id') + '/catagories/reorder',
					async: false,
					type: "PUT",
					dataType: 'json',
					data: {
						catagories: alteredCatagories
					},
					success: function (resp) {

					},
					error: function (resp) {
					
					}
				});
			}
		};
	
	$('#board-lists').sortable({
		stop: function (event, ui) {
			reorderLists();
		}
	});
	
});