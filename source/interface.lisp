(in-package :cl-webengine)

(defvar callback-counter 0)
(defvar callbacks ())
(defstruct callback
  (id)
  (web-view)
  (function))

(defcfun ("newLoadStartedListener" new-load-started-listener) :pointer
  (id :int)
  (callback :pointer))
(export 'new-load-started-listener)

(defcfun ("loadStartedListenerConnect" %load-started-listener-connect) :void
  (load-started-listener :pointer)
  (web-engine-view :pointer))

(defun load-started-listener-connect (web-engine-view callback)
  (incf callback-counter)
  (push (make-callback :id callback-counter :function callback) callbacks)
  (%load-started-listener-connect
   (new-load-started-listener callback-counter (cffi:callback load-started))
   web-engine-view))
(export 'load-started-listener-connect)

(cffi:defcallback load-started
    :void ((id :int))
  (let* ((callback (find id callbacks :key (function callback-id))))
    (setf callbacks (delete callback callbacks))
    (when (callback-function callback)
      (funcall (callback-function callback)))))

(defcfun ("newQApplication" new-q-application) :pointer
  (argc :int)
  (argv :pointer))
(export 'new-q-application)

(defcfun ("applicationExec" application-exec) :int
  (application :pointer))
(export 'application-exec)

(defcfun ("applicationQuit" application-quit) :void
  (application :pointer))
(export 'application-quit)

(defcfun ("newQWidget" new-q-widget) :pointer)
(export 'new-q-widget)

(defcfun ("newQPushButton" new-q-push-button) :pointer
  (label :string))
(export 'new-q-push-button)

(defcfun ("newQVBoxLayout" new-qv-box-layout) :pointer)
(export 'new-qv-box-layout)

(defcfun ("newQHBoxLayout" new-qh-box-layout) :pointer)
(export 'new-qh-box-layout)

(defcfun ("newQWebEngineView" new-q-web-engine-view) :pointer)
(export 'new-q-web-engine-view)

(defcfun ("webEngineViewLoad" web-engine-view-load) :void
  (webEngineView :pointer)
  (url :string))
(export 'web-engine-view-load)

(defcfun ("webEngineViewPage" web-engine-view-page) :pointer
  (webEngineView :pointer))
(export 'web-engine-view-page)

(defcfun ("webEnginePageRunJavaScript" web-engine-page-run-javascript) :void
  (webEnginePage :pointer)
  (javascript :string))
(export 'web-engine-page-run-javascript)

(defcfun ("layoutAddWidget" layout-add-widget) :void
  (layout :pointer)
  (widget :pointer))
(export 'layout-add-widget)

(defcfun ("widgetSetLayout" widget-set-layout) :void
  (widget :pointer)
  (layout :pointer))
(export 'widget-set-layout)

(defcfun ("widgetSetParent" widget-set-parent) :void
  (widget :pointer)
  (parent :pointer))
(export 'widget-set-parent)

(defcfun ("widgetShow" widget-show) :void
  (widget :pointer))
(export 'widget-show)

(defcfun ("widgetResize" widget-resize) :void
  (widget :pointer)
  (width :int)
  (height :int))
(export 'widget-resize)

(defcfun ("widgetSetFixedHeight" widget-set-fixed-height) :void
  (widget :pointer)
  (height :int))
(export 'widget-set-fixed-height)

(defcfun ("widgetSetFixedSize" widget-set-fixed-size) :void
  (widget :pointer)
  (width :int)
  (height :int))
(export 'widget-set-fixed-size)

(defcfun ("windowSetWindowTitle" window-set-window-title) :void
  (window :pointer)
  (title :string))
(export 'window-set-window-title)

(defcfun ("windowShowFullScreen" window-show-full-screen) :void
  (window :pointer))
(export 'window-show-full-screen)

(defcfun ("windowShowNormal" window-show-normal) :void
  (window :pointer))
(export 'window-show-normal)

(defcfun ("windowIsActiveWindow" %window-is-active-window) :int
  (window :pointer))

(defun window-is-active-window (window)
  (if (> (%window-is-active-window window) 0) t nil))
(export 'window-is-active-window)

(defcfun ("layoutSetContentsMargins" layout-set-contents-margins) :void
  (layout :pointer)
  (left :int)
  (top :int)
  (right :int)
  (bottom :int))
(export 'layout-set-contents-margins)

(defcfun ("layoutSetSpacing" layout-set-spacing) :void
  (layout :pointer)
  (spacing :int))
(export 'layout-set-spacing)

(defcfun ("layoutInsertWidget" layout-insert-widget) :void
  (layout :pointer)
  (index :int)
  (widget :pointer))
(export 'layout-insert-widget)
