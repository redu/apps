// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery.cookie
//= require modernizr
//= require jquery.autosize.min
//= require placeholder-polyfill.min
//= require bootstrap-redu
//= require jquery_ujs
//= require_tree .

$(function() {
  // Expande/colapsa a explicação dos REA.

  var oerLinkClass = '.apps-portal-oer-link';
  var oerCloseClass = '.apps-portal-oer-close';
  var $oerLink = $(oerLinkClass);
  var $oerArea = $(oerCloseClass).parents('.apps-portal-oer');
  var warned = $.cookie("oer_explaination");

  if (warned) {
    // O usuário já fechou a explicação uma vez, então a mantém escondida.
    $oerArea.hide();
  } else {
    // Se o usuário ainda não fechou a explicação pelo menos uma vez.
    $oerLink.hide();
  }

  $('body').on('click', oerCloseClass, function(e) {
    // Colapsa a explicação.
    e.preventDefault();
    $oerArea.slideToggle('fast', function() {
      $oerLink.show('fast');
      // Cria um cookie pra salvar que o usuário fechou a explicação.
      $.cookie("oer_explaination", true, { path: "/" });
    });
  }).on('click', oerLinkClass, function(e) {
    // Expande a explicação.
    e.preventDefault();
    $oerLink.hide('fast', function() {
      $oerArea.slideToggle('fast');
    });
  });

  // Cria uma janela modal específica para abrir um aplicativo.
  $('body').on('click', '[data-toggle="modal-app"]', function(e) {
    e.preventDefault();
    var $this = $(this);

    // Cria a modal.
    var $modal = $(document.createElement('div'))
      .attr({
        'id': $this.attr('href')
      , 'class': 'modal hide modal-fill-horizontal'
      });
    var $header = $(document.createElement('div'))
      .attr('class', 'modal-header')
      .append($(document.createElement('h3')).attr('class', 'modal-title').html($this.data('modal-title')))
      .append($(document.createElement('span')).attr('class', 'modal-subtitle').html($this.data('modal-subtitle')));
    var $body = $(document.createElement('div'))
      .attr('class', 'modal-body')
      .append($(document.createElement('iframe')).attr({
        'frameborder': '0'
      , 'scrolling': 'no'
      , 'src': $this.data('modal-url')
      }))
    var $footer = $(document.createElement('div'))
      .attr('class', 'modal-footer')
      .append($(document.createElement('button')).attr({
        'class': 'button-default'
      , 'data-dismiss': 'modal'
      }).html('Fechar'));
    $('body').append($modal.append($header).append($body).append($footer));

    // Evita que ela seja fechada com Esc ou clicando fora.
    $modal.data('backdrop', 'static');
    $modal.data('keyboard', 'false');

    // Abre a modal.
    $modal.modal('show').reduModal('fillHorizontal');

    // Remove a modal quando for fechada.
    $modal.on('hidden', function(e) {
      $modal.remove();
    })
  });


  // Submete o formulário do passo 1 do "Adicionar à Disciplina" através de links.
  $(document).on("click", "#step-1-form .space-link", function(e) {
    e.preventDefault();
    $("#space_id").val($(this).data("space-id"));
    $("#step-1-form").submit();
  });

  // Remove as janelas modais quando fechadas.
  $(document).on("hidden", ".modal-add-oer", function(e) {
    $(this).remove();
  });
});

