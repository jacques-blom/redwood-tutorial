import BlogLayout from 'src/layouts/BlogLayout/BlogLayout'
import BlogPostsCell from 'src/components/BlogPostsCell'

const HomePage = () => {
  return (
    <>
      <BlogLayout>
        <BlogPostsCell />
      </BlogLayout>
    </>
  )
}

export default HomePage
