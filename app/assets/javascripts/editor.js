$(function(){
    ClassicEditor
        .create( document.querySelector( '#editor' ), {
            ckfinder: {
                // uploadUrl: '/ckfinder/core/connector/php/connector.php?command=QuickUpload&type=Files&responseType=json',
                uploadUrl: 'https://s3.console.aws.amazon.com/s3/buckets/s3のパス',
            },
            toolbar: [ 'ckfinder', 'imageUpload', '|', 'heading', '|', 'bold', 'italic', '|', 'undo', 'redo' ]
        } )
    .catch( error => {
        console.error( error );
    } );
    width:500;
    height:100;
});
