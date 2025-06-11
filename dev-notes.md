#### Gotchas working with Rails Authentication
1. `Current.user` will be nil on pages that do not require authentication. To put value, call `authenticate?` before calling `Current.user`
2. To make ViewComponent work with Pundit in views, you have to call `Pundit.policy(Current.user, @record).method?` (ref: https://dev.to/jerryweyer/how-to-get-pundit-to-work-with-rails-view-component-2kdg)

#### Other Notes
1. TailwindCSS string interpolation does not work since tailwind runs at build time and string interpolation doesn't happen until runtime