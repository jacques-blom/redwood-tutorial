import BlogPostCell from 'src/components/BlogPostCell'
import BlogLayout from 'src/layouts/BlogLayout/BlogLayout'

const BlogPostPage = ({ id }) => {
  return (
    <BlogLayout>
      <BlogPostCell id={id} />
    </BlogLayout>
  )
}

export default BlogPostPage
