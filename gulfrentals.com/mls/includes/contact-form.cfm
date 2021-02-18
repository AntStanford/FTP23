<style>
#contact-form { display: block; *zoom: 1; }
#contact-form:after { content: ""; display: table; clear: both; }
#contact-form label { font-size: 85%; text-align: right; word-break: break-word; display: block; float: left; margin: 0 3% 15px 0; padding: 0; width: 15%; position: relative; }
#contact-form label.required:after { display: block; content: "*"; font: 100% Arial; color: red; position: absolute; top: 0; right: -6px; }
#contact-form input[type=text], #contact-form input[type=email], #contact-form input[type=tel], #contact-form textarea { border: 1px #ccc solid; margin: 0 0 15px; padding: 5px 8px; width: 79%; float: left; -webkit-border-radius: 3px; -moz-border-radius: 3px; -ms-border-radius: 3px; -o-border-radius: 3px; border-radius: 3px; }
#contact-form textarea { min-height: 75px; }
#contact-form span { display: block; clear: both; padding: 15px; background: #f1f1f1; }
#contact-form span input { position: relative; left: 16%; }
/* .contact-button{position:absolute;top:0;right:0} */
</style>
<!--- <a href="#inquire" class="button contact-button">Inquire About Property</a> --->
<!--- <a name="inquire"></a> --->
<form id="contact-form">
  <h2>Inquire About Property</h2>
  <p>Please fill out the form below</p>
  <label class="required">Name</label>
  <input type="text" required="required">
  <label class="required">Email</label>
  <input type="email" required="required">
  <label>Phone</label>
  <input type="tel">
  <label>Comments</label>
  <textarea></textarea>
  <span>
    <input type="submit" value="Submit" class="button">
    <input type="reset" value="Cancel" class="button light">
  </span>
</form>