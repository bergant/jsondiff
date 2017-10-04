HTMLWidgets.widget({

  name: 'jsondiff',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {

        var defaultObjHash = function(obj, index) {
          if (typeof obj._id !== 'undefined') {
            return obj._id;
          }
          if (typeof obj.id !== 'undefined') {
            return obj.id;
          }
          if (typeof obj.name !== 'undefined') {
            return obj.name;
          }
          return '$$index:' + index;
        };

        xObj = JSON.parse(x);
        var objectHash = xObj.objectHash;
        if(objectHash == 'undefined') {
          objectHash = defaultObjHash;
        } else {
          eval("objectHash = " + objectHash);
        }

        /* global jsondiffpatch */
        var instance = jsondiffpatch.create({
          objectHash: objectHash
        });


    		try {
    		  var delta = instance.diff(xObj.x1, xObj.x2);

    		  if (typeof delta === 'undefined') {
    			  el.innerHTML = 'no diff';
    		  } else {
            switch (xObj.formatter) {
              case 'html':
                el.innerHTML = jsondiffpatch.formatters.html.format(delta, xObj.x1);
          			if (xObj.hideUnchanged) {
          			  jsondiffpatch.formatters.html.hideUnchanged();
          			}
                break;
              case 'annotated':
                el.innerHTML = jsondiffpatch.formatters.annotated.format(delta);
                break;
              case 'json':
                el.innerHTML = "<pre>" + JSON.stringify(delta, null, 2) + "</pre>";
                break;
            }
    		  }
    		} catch (err) {
    		  el.innerHTML = '';
    		  if (typeof console !== 'undefined' && console.error) {
    			console.error(err);
    			console.error(err.stack);
    		  }
    		}


      },

      resize: function(width, height) {

      }

    };
  }
});




