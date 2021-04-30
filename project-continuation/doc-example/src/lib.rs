//! Fast and easy `foo` availability.
//!
//! Provides an abstraction over a function `foo`.  When the abstraction is used
//! there are these advantages:
//! - Fast
//! - Easy

/* Note on comments:
- '//': one-liner
- ´/**/´: block comment
- '///': doc-comment above declaration
- #[doc = "<txt>"]: doc-comment above declaration
- '//!': doc-comment below declaration
*/

#![doc(html_favicon_url = "https://media-exp1.licdn.com/dms/image/C4D03AQEgpsQjJQna5Q/profile-displayphoto-shrink_800_800/0/1516302144883?e=1625097600&v=beta&t=PRQ021mrDuM9N3YRVaAL3GGlYKSDRnRsHV4_VI6hGXs")]
#![doc(html_logo_url = "https://media-exp1.licdn.com/dms/image/C4D03AQEgpsQjJQna5Q/profile-displayphoto-shrink_800_800/0/1516302144883?e=1625097600&v=beta&t=PRQ021mrDuM9N3YRVaAL3GGlYKSDRnRsHV4_VI6hGXs")]

/// This module makes it easy.
pub mod easy {

    /// Use the abstract function to do this specific thing.
    /// 
    /// Example
    /// ```
    /// # use simplest::easy;
    /// # fn main() {
    /// let two = easy::foo();
    /// # }
    /// ```
    /// ```should_panic
    /// # use simplest::easy::foo;
    /// assert_eq!(foo(), 3);
    /// ```
    pub fn foo() -> usize { 
        1 + 1 
    }
}