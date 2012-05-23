window.arbor = {
	server:{
		checkin:function(accession){
			return $.ajax('/checkouts/checkin',{
				type:'POST',
				data:{
					'accession':accession
				},
				success:function(resp) {
					console.log(resp);
				},
				error:function(){
					console.log("ajax call to try to checkin failed.")
				}
			})
		},
		libraryCard:function(cardNumber){
/*			return $.ajax('/users/scancard',{
				data:{'card':cardNumber}
			}) */
		}
	},
	checkinForm:function() {
		var frm = $('<form><input type="text" name="accession"></input></form>')
	}
}